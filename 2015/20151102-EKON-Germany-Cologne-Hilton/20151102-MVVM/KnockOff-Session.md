# [KnockOff](https://bitbucket.org/sglienke/knockoff): to show how MVVM in Delphi can work.

[Köln, Germany, 20151103](http://web.archive.org/web/20151101154136/http://entwickler-konferenz.de/2015/de/sessions/how-partition-your-applications-using-model-view-viewmodel)

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

### Bindings what and how

The `Bindings` handle the traffic from/to the UI to/from the ViewModel.

Bindings use a non-generic `TDependentObservable` and can capture one or more events of the `TComponent` that they bind. This is OK, as the whole point is that you should not have your own event handling in the UI.

They can user the `TDependentObservable` as they know which types will be mapped.

The underlying mechanism of `TDependentObservable` and `TDependentObservable<T>` are the same, which means the binding between the UI and the ViewModel works in the same way as the ViewModel binds to the Model. This sets it totally apart from the Caliburn binding.

### Specifying Bindings

Note that almost all of the bindings use strings so they are not checked by the compiler.   
This is just like `.dfm` files: that text isn't checked by the compiler either.  

I'm not alone in [wishing](https://plus.google.com/wm/trollface-meme-troll-gif-pics-lol-funny/+StefanGlienke/posts/AsGHSLF4rTX) that Delphi had a feature like the [C#/VB.net `nameof`](https://msdn.microsoft.com/en-us/library/dn986596.aspx) like Delphi has [TypeInfo](http://docwiki.embarcadero.com/Libraries/en/System.TypeInfo) (formerly [TypeOf](http://docwiki.embarcadero.com/Libraries/en/System.TypeOf)).

That would make bindings like thess:

```#!delphi
type
  TMainViewForm = class(TForm)
...
    [Bind('Value', 'FirstName')]
    edtFirstName: TEdit;
    [Bind('Text', 'FullName')]
    lblFullName: TLabel;
...
    [Bind('Click', 'RegisterClick')]
    [Bind('Disabled', 'HasClickedTooManyTimes')]
    btnRegisterClick: TButton;

    [Bind('Value', 'ChosenTicket')]
    [BindOptions('Tickets')]
    [BindOptionsCaption('Choose...')]
    [BindOptionsText('Name')]
    cbTickets: TComboBox;
...
    procedure FormCreate(Sender: TObject);
  end;
...
```

become something like this:

```#!delphi
type
  TMainViewForm = class(TForm)
...
    [Bind('Value', NameOf(TViewModel.FirstName))]
    edtFirstName: TEdit;
    [Bind('Text', 'FullName')]
    lblFullName: TLabel;
...
    [Bind('Click', NameOf(TViewModel.RegisterClick))]
    [Bind('Disabled', NameOf(TViewModel.HasClickedTooManyTimes))]
    btnRegisterClick: TButton;

    [Bind('Value', NameOf(TViewModel.ChosenTicket))]
    [BindOptions(NameOf(TViewModel.Tickets))]
    [BindOptionsCaption('Choose...')]
    [BindOptionsText(NameOf(TTicket.Name))]
    cbTickets: TComboBox;
...
    procedure FormCreate(Sender: TObject);
  end;
...
```

> Note that Knockoff uses the same binding names as in Knockout, which might be odd for Delphi developers:
> - [`'Value'`](http://knockoutjs.com/documentation/value-binding.html) as binding for user input controls like `TText` or `TComboBox`.
> - [`'Text'`](http://knockoutjs.com/documentation/text-binding.html) as binding for display controls like `TLabel`.
> - [`Disabled`](http://knockoutjs.com/documentation/disable-binding.html) maps to `not Enabled`.
> - [`Click`](http://knockoutjs.com/documentation/click-binding.html) maps to the `OnClick` event.
> - [`Checked`](http://knockoutjs.com/documentation/checked-binding.html) is the `Checked` property.
> - For list based controls (which have an `Items` property), `BindOptions`, `BindOptionsCaption` and `BindOptionsText` will implement the [options binding](http://knockoutjs.com/documentation/options-binding.html) from Knockout.  
>  `BindOptions` tells where the list comes from. `BindOptionsText` tells which property from each list item to fill the list based control with.

### Starting the binding process

You kick off the binding by calling these methods:

```!#delphi
procedure ApplyBindings(const view: TComponent; const viewModel: TObject);
procedure ApplyBindingsByConventions(const view: TComponent; const viewModel: TObject);
```

You call them from your `OnCreate` event in your `View`:

```!#delphi
procedure TMainViewForm.FormCreate(Sender: TObject);
begin
  ApplyBindings(Self, TViewModel.Create('John', 'Doe'));
end;
```

The first will bind using `BindingAttribute` instances.  
The second will bind by conention: currently hardcoded to `TEdit` or `TLabel` components where the name matches a property in the `viewModel`.

Both will make the `View` owner of the `ViewModel` when the `ViewModel` descends from `TComponent` and the `ViewModel` has no owner yet.




## Example

Note that KnockOff is an experimental proof of concept. Not all notifications arrive on time, so some min/max checks give different results than in Calinurn. Same for the exceptions raised.

### Step 00 - empty app like Caliburn

### Step 01 - add ViewModel and AppViewModelTestCase

### Step 02 - bind View to ViewModel

VCL app needs $(Knockoff) in the search path.

### Step 03 - skipped - Knockout doesn't use interfaces for the ViewModel

This is because JavaScript doesn't support interfaces; [JavaScript has Duck typing instead](http://stackoverflow.com/questions/3710275/does-javascript-have-the-interface-type-such-as-javas-interface).

### Step 04 - partially skipped - form captions are not supported yet

### Step 05 - add Count property and Control

### Step 06 - bind Count Control to Count property

Either by convention or explicitly.

[Knocukout can do convention over configuration](https://mattduffield.wordpress.com/2012/09/30/knockoutjs-and-convention-over-configuration/) using for instance [Knockout.BindingConventions](https://github.com/AndersMalmgren/Knockout.BindingConventions). Knockoff has a few harcoded ones.

### Step 07 - add buttons for increment/decrement Count

Manual binding needed: convention is not yet supported.

### Step 08 - limiting the range of Countbetween -10 and +10

Some unit tests fail now, but that's ok: we will fix them in the next step.

Note that throwing Exceptions should be avoided in the ViewModel of MVVM (they are more OK in the Model), but lets try to make things not too overly complicated right now.

### Step 09 - ensuring the unit test results make sense

### Step 10 - modified - no support for Actions in Knockoff yet

### Step 11 - skipped - no logging in Knockoff yet

### Step 12 - unit tests for *2 and +2 and manual bindings from View to ViewModel

Note that manual bindings will not work for `TCombBox` (`Options` binding) as that attribute has a lot of internal logic in method `procedure BindOptionsAttribute.ApplyBinding(...)`

For Manual Bindings, you also have to ensure you free the ViewModel, easiest is by owning it:

    InsertComponent(LAppViewModel);

### Step 13 - modified - increment by a specified value

Here we have to make a `TTrackBarBinding` and modify `GetBindingClass` so `Bind` can create the correct binding class instance.

### Step 14 - adding a model

This looks different than in Caliburn as the model now also uses Observers.

## Reporting issues

Like any software, Knockoff can have issues especially since it's a proof-of-concept prototype.

There is no issue tracker yet, so contact me if you bump into things

## Time to play

1. Make a small calculator that can multiply/divide.
2. Show a nice message when divide is not possible.
