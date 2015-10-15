# [KnockOff](https://bitbucket.org/sglienke/knockoff): to show how MVVM in Delphi can work.

[Nyborg, Denmark, 20151021](http://www.dapug.dk/2015/08/workshop-20.html)

- Examples: <https://bitbucket.org/jeroenp/besharp.net>
- Slides: <http://github.com/jpluimers/Conferences>
- Blog: <http://wiert.me>

    Core of the library is the Observable<T> type which is an anonymous method type which is overloaded. So it combines being getter and setter in one type.

## Background

[KnockOff](https://bitbucket.org/sglienke/knockoff) is based in the ideas behind the JavaScript [knockoutjs](http://knockoutjs.com/index.html) which foundation consists of [Observables](http://knockoutjs.com/documentation/observables.html) and [Computed Observables](http://knockoutjs.com/documentation/computedObservables.html) formerly called [Dependent Observables](http://knockoutjs.com/documentation/dependentObservables.html). KnockOff still calls them Dependent Observables.

JavaScript uses functions and methods to cover the `getter` and `setter` functionality needed by the `Observable` framework and a notification mechanism to update the whole tree of instances.

Knockout then binds the UI to the ViewModel through all sorts of [bindings](http://knockoutjs.com/documentation/visible-binding.html) which KnockOff also uses.

It is quite amazing that the concepts of JavaScript used by KnockOff can be quite well mapped to the Delphi language features.

The reason is that in Delphi, a method reference maps to an interface which you can extend and implment. If you map getter to a `TFunc<T>` and a getter to a `TProc<T>` and bind these two together, then your done.

Stefan Glienke explains the fundamentals of KnockOff very densly at http://delphisorcery.blogspot.com/2015/06/anonymous-method-overloading.html

Lets elaborate a bit on that.

## Implementation

### `Observable` and `Computed` implemented by `TObservable<T>` and `TDependentObservable<T>`

First, Delphi needs something similar to the `Observables` and `computedObservables` in knockoutjs
The `Observable` record has class methods to create `Observable: Observable<T>` (internally `TObservable<T>`) or `Computed: Observable<T>` (internally `TDependentObservable<T>`).

`TObservable<T>` stores values. `TDependentObservable<T>` stores a `getter` and a `setter` and can `Evaluate` a value.

Both `TObservable<T>` and `TDependentObservable<T>` descend from `TObservableBase` which has instance lists of `Dependencies` and `Subscribers`, an instance `Notify` method and a class level `ObservableStack` which is used to manage evaluations.

The `Observable<T>` interface (see below) has a `Notification` method for `TNotifyTrigger` which can have the values `AfterChange, BeforeChange`.

If this sounds just like a publish/framework to you, then you are right: it is.

### from getters and setters to `Observable<T>`

For Observables to work, you need a kinf of 'property' with a getter and optionally setter.

But you want to store that 'property' in a field so you can use that field as an indirection to call the getter and setter.

For getters, you could use a `TFunc<T>` and for setters `TProc<T>`. But to combine them you'd need to combine a `TFunc<T>` and `TProc<T>` in one type.

Luckily you can do that because of the way the Object Pascal compiler implements `TFunc<T>`: it implicitly generates an interface with an `Invoke` method.

[Barry Kelly](https://twitter.com/barrkel) (a [former compiler engineer](http://blog.barrkel.com/2012/09/moving-on.html)) in 2008 already [mentioned](http://blog.barrkel.com/2008/08/tiburon-fun-with-generics-and-anonymous.html) that method references are 'managed types, like strings and interfaces'. Later that year he actually [showed that the compiler maps a method reference to an interface](http://blog.barrkel.com/2008/11/reference-counted-pointers-revisited.html?showComment=1225669020000#c6927736917741913543) having an `Invoke` method and then [used this mapping feature to implement smart pointers](http://blog.barrkel.com/2008/11/somewhat-more-efficient-smart-pointers.html).

In 2011, the ADUG transformed Barry's last post in a [more elaborate example](http://www.adug.org.au/technical/language/smart-pointers/) (which WordPress mangled the source code of) and Stefan Glienke (sounds familiar? :) responded with an [implementation that leads to more readable usage](http://www.adug.org.au/technical/language/smart-pointers/#comment-30).

Anyway: in his last post, Barry he shows that you can implement `TFunc<T>` by this class implementing `Invoke: T` which you can basically view as a `getter`:

```#!delphi
type
  TObjectHandle<T: class> = class(TInterfacedObject, TFunc<T>)
  private
    FValue: T;
  public
    constructor Create(AValue: T);
    destructor Destroy; override;
    function Invoke: T;
  end;
```

In other words `TFunc<T>` is equivalent to an `interface` having `function Invoke: T`.
>  In 2009 Embarcadero [more-or-less documented this in their C++ documentation](http://docs.embarcadero.com/products/rad_studio/delphiAndcpp2009/HelpUpdate2/EN/html/devwin32/handlinganonymousmethods_xml.html) which was [promoted to their docwiki](http://docwiki.embarcadero.com/RADStudio/2010/en/How_to_Handle_Delphi_Anonymous_Methods_in_C%2B%2B).

Similarly, `TProc<T>` is equivalent to an `interface` having  `procedure Invoke(value: T)`.  
You can go on and on with `TFunc<Tin, Tout>`, `TProc<T1, T2>` all being equivalent to interfaces with `Invoke` methods having a varying number of parameters and results.

Stefan already combined `TFunc<T>` and `TProc<T>` into `TProp<T>` in his blog post
[Property references in Delphi - possible?](http://delphisorcery.blogspot.nl/2011/07/property-references-in-delphi-possible.html): you can implement more than one interface in class.

KnockOff brings this all together: it extends the above `TFunc<T>` concept by extending that generated interface with a method `Invoke(const value: T)` that now can function as a `setter` (which is `TAction<T>` and is like `TProc<T>` but with a `const` argument):

```#!delphi
type
  {$M+}
  ReadOnlyObservable<T> = reference to function: T;
  Observable<T> = interface(ReadOnlyObservable<T>)
  {$REGION 'Property Accessors'}
    procedure Invoke(const value: T); overload;
  {$ENDREGION}
    procedure Subscribe(const action: TAction<T>; trigger: TNotifyTrigger = AfterChange);
  end;
  {$M-}
```

Then KnockOff has two implementations of this interface `TObservable<T>` and `TDependentObservable<T>` descending from `TObservableBase` which has abstract `GetValue` and `SetValue` methods:

```#!delphi
TObservable<T> = class(TObservableBase, Observable<T>)
...
{$REGION 'Property Accessors'}
  function GetValue: TValue; override; final;
  procedure SetValue(const value: TValue); override; final;
  function Invoke: T; overload;
  procedure Invoke(const value: T); overload;
{$ENDREGION}
...
end;

TDependentObservable<T> = class(TObservableBase, Observable<T>)
...
{$REGION 'Property Accessors'}
  function GetValue: TValue; override; final;
  procedure SetValue(const value: TValue); override; final;
  function Invoke: T; overload;
  procedure Invoke(const value: T); overload;
{$ENDREGION}
...
end;
```

Do you have a headache already? Don't worry: just trust this code works and be amazed about what it can do.

## from UI to ViewModel

The `Bindings` handle the traffic from/to the UI to/from the ViewModel.

Bindings use a non-generic `TDependentObservable` and can capture one or more events of the `TComponent` that they bind. This is OK, as the whole point is that you should not have your own event handling in the UI.

They can user the `TDependentObservable` as they know which types will be mapped.

The underlying mechanism of `TDependentObservable` and `TDependentObservable<T>` are the same, which means the binding between the UI and the ViewModel works in the same way as the ViewModel binds to the Model. This sets it totally apart from the Caliburn binding.

## Example

Note that almost all of the bindings use strings so they are not checked by the compiler.   
This is just like `.dfm` files: that text isn't checked by the compiler either.  

I'm not alone in [wishing](https://plus.google.com/wm/trollface-meme-troll-gif-pics-lol-funny/+StefanGlienke/posts/AsGHSLF4rTX) that Delphi had a feature like the [C#/VB.net `nameof`](https://msdn.microsoft.com/en-us/library/dn986596.aspx) like Delphi has [TypeInfo](http://docwiki.embarcadero.com/Libraries/en/System.TypeInfo) (formerly [TypeOf](http://docwiki.embarcadero.com/Libraries/en/System.TypeOf)).

--------------------------------------------------------------------------------------

TODO

--------------------------------------------------------------------------------------
