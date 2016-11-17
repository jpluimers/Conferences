https://deadlockempire.github.io/
#################################

.. # * = + ^ ~ - : . _ ` ' "

Explanation of each level
*************************

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Tutorials
=========

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Tutorial 1: Interface
+++++++++++++++++++++

1. ``Thread 0``: click ``Step`` until at ``critical_section();``.
2. ``Thread 1``: click ``Step`` until at ``critical_section();``.

Race condition: both threads in the in same ``critical_section();``.

Accomplishment:

  Well done, player! There are a few more important things you must learn before you will be able to play **The Deadlock Empire** on your own. Please move to the next tutorial challenge to learn about them.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Tutorial 2: Non-Atomic Instructions
+++++++++++++++++++++++++++++++++++

1. ``Thread 0``: click ``Expand`` to see the atomic instructions of the first line.
2. ``Thread 0``: click ``Step`` until at ``a = temp;``.
   You don't see the value of ``temp``, but it's 1. ``a`` still has a value of ``0``.
3. ``Thread 1 ``: click ``Step`` until at ``critical_section();``.
4. ``Thread 0``: click ``Step`` until at ``critical_section();``.

Race condition: both threads in the in same ``critical_section();``.

At step 3., there is no need to press ``Expand`` like in ``Thread 0`` as there ``temp`` already has the value ``1`` needed in both of the ``if`` statements.

Accomplishment:

  Congratulations! You have completed the tutorial! You may now either proceed with the first non-tutorial level (very easy) or choose a level from the main menu yourself. We hope you will have fun playing this game!

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Unsynchronized Code
===================

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Boolean Flags Are Enough For Everyone
+++++++++++++++++++++++++++++++++++++

1. ``Thread 0``: click ``Step`` until at ``flag = true;``.
2. ``Thread 1``: click ``Step`` until at ``flag = true;``.
3. ``Thread 0``: click ``Step`` until at ``critical_section();``.
4. ``Thread 1``: click ``Step`` until at ``critical_section();``.

Race condition: both threads in the in same ``critical_section();``.

Accomplishment:

  Congratulations!

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Simple Counter
++++++++++++++

1. ``Thread 1``: click ``Step`` until at ``critical_section();`` and ``System.Int32counter=3;``.
2. ``Thread 0``: click ``Step`` until at ``critical_section();`` and ``System.Int32counter=5;``.

Race condition: both threads in the in same ``critical_section();``.

Accomplishment:

  As you have seen previously, once you pass a test, such as an integer comparison, you don't care about what other threads do to the operands - you have already passed the test and may continue to the critical section. To fix this program, locks would be needed.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Confused Counter
++++++++++++++++



1. ``Thread 0``: click ``Step`` until at ``first++;``.
2. ``Thread 0``: click ``Expand``.
3. ``Thread 0``: click ``Step`` until at ``first = temp;``.
4. ``Thread 1``: click ``Step`` until the thread finishes.
5. ``Thread 0``: click ``Step`` until after ``Debug.Assert(false);``.

Assert fired.

Accomplishment:

  And yet again the Wizard's tactics have been foiled! Hurray for simplicity!

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Locks
=====

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Insufficient Lock
+++++++++++++++++

1. ``Thread 1``: click ``Step`` until at ``}`` so ``i`` has value ``-1``.
2. ``Thread 0``: click ``Step`` until after ``Debug.Assert(false);`` as the value of ``i`` will go have the sequence ``-1``, ``1``, ``3``, ``5``.

Assert fired.

Accomplishment:

  Locks are the most commonly used synchronization primitive. It is very useful to know them.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Deadlock
++++++++

1. ``Thread 1``: click ``Step`` until at first ``Monitor.Enter(mutex);`` so it has ``mutex2`` locked.
2. ``Thread 0``: click ``Step`` until at first ``Monitor.Enter(mutex2);``.

Deadlock: both ``mutex`` and ``mutex2`` are locked in a cross-thread fashion.

Solution from programming point of view: lock mutexes in the same order in each thread.

Accomplishment:

  This was the most simple deadlock scenario - two threads mutually waiting for each other, because each was stuck on a different lock.
  Congratulations all the same for solving it!

  To avoid deadlocks in your programs, be very dilligent whenever you grab multiple locks.
  If two threads need the same locks, locking and unlocking them in the same order in both threads is one way to avoid deadlocking the two threads.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

A More Complex Thread
+++++++++++++++++++++

1. ``Thread 1``: click ``Step`` until at ``Monitor.Exit(mutex);`` in ``else`` clause so ``mutex`` is locked.
2. ``Thread 0``: click ``Step`` until at ``Monitor.Exit(mutex2);`` in ``else`` clause so ``flag`` has value ``true`` and  ``mutex2`` is locked.
3. ``Thread 1``: click ``Step`` until at ``Monitor.Enter(mutex2);`` in ``if`` clause.
4. ``Thread 0``: click ``Step`` until at ``Monitor.Enter(mutex2);`` in ``if`` clause so ``mutex`` is locked.
5. ``Thread 1``: click ``Step`` until at ``Monitor.Enter(mutex);`` in ``if`` clause so ``mutex2`` is locked.

Deadlock: both ``mutex`` and ``mutex2`` are locked in a cross-thread fashion.

Accomplishment:

  The `Monitor.TryEnter() <https://msdn.microsoft.com/en-us/library/system.threading.monitor.tryenter>`_ method, if successful, also locks the mutex and in C#, objects can be locked recursively.
  In order for a lock to be released, it must be *exited* the same number of times it was *entered*.
  In this game, you saw that there is no matching ``Monitor.Exit()`` call to the ``.TryEnter()`` call and thus the first thread was able to lock the object,
  recursively, many times, making it impossible for the second thread to lock it.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Manual Reset Event
++++++++++++++++++

1. ``Thread 0``: click ``Step`` until at ``sync.Wait();`` as sync is ``not signaled``.
2. ``Thread 1``: click ``Step`` until at ``}`` so ``sync`` becomes ``signaled`` (and ``counter`` has value ``2``).
3. ``Thread 0``: click ``Step`` until at ``if (counter % 2 == 1) {``.
4. ``Thread 1``: click ``Step`` until at second ``counter++;`` so ``counter`` has value ``3``.
5. ``Thread 0``: click ``Step`` until after ``Debug.Assert(false);`` because ``(counter % 2 == 1`` now is ``true``.

Solution from programming point of view: ensure "status transfer" variables between threads are either:

- properly locked during write and read operations
- atomically accessed from write and read threads using for instance the `interlocked <https://msdn.microsoft.com/en-us/library/system.threading.interlocked.aspx>`_ class or `InterlockedIncrement <https://msdn.microsoft.com/en-us/library/windows/desktop/ms683614.aspx>`_ method.

Accomplishment:

  You've done well. Using ``ManualResetEventSlim`` is trickier if you use both ``Set()`` and ``Reset()`` rather than only ``Set()``.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Countdown Event
+++++++++++++++

1. ``Thread 0``: click ``Expand``.
2. ``Thread 0``: click ``Step`` until at ``progress = temp;``.
3. ``Thread 1``: click ``Step`` until at ``if (progress >= 30) {`` and ``progress`` has value ``30``.
4. ``Thread 0``: click ``Step`` until after ``event.Wait();`` and ``progress`` has value ``20``.
5. ``Thread 1``: click ``Step`` until after ``event.Wait();`` and ``event`` still needs ``1` more ``Signal`` calls.

Deadlock: both threads wait for ``event`` to get state ``signaled``.

Accomplishment:

  Yes! When using the `CountdownEvent <https://msdn.microsoft.com/en-us/library/system.threading.countdownevent>`_,
  you must make extra sure that you are not leaving yourself open to deadlocks - the ``.Wait()`` calls will block indefinitely if not enough ``.Signal()`` calls have been made.
  Suppose you use the ``CountdownEvent`` for loading data. If one of threads fails to load data and somehow crashes,
  therefore not signalling, the program will be blocked and you won't be able to terminate the waiting threads.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Countdown Event Revisited
+++++++++++++++++++++++++

1. ``Thread 0``: click ``Step`` until at ``progress = progress + 20;``.
2. ``Thread 0``: click ``Expand.``.
3. ``Thread 0``: click ``Step`` until at ``progress = temp;``.
4. ``Thread 1``: click ``Step`` until at ``event.Wait();`` and ``1`` more ``Signal``.
5. ``Thread 1``: click ``Step`` until at second time ``event.Signal();`` where ``event`` has state ``set``.

Crash: tried to ``Signal`` a ``CountdownEvent`` that has already had ``Count`` calls to ``Signal`` which would force the countdown timer below zero.

  Note there are more ways to make this level crash.

A solution would be to use atomic change operations on the ``progress`` variable.

Accomplishment:

  The high-level synchronization primitives such as `CountdownEvent <https://msdn.microsoft.com/en-us/library/system.threading.countdownevent>`_ are very safe and throw exceptions whenever something bad happens.
  For example, as you have just seen, it is impossible to signal if the event counter is already at zero. Good job!

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

The Barrier
+++++++++++

1. ``Thread 0``: click ``Step`` until after ``barrier.SignalAndWait();``.
2. ``Thread 2``: click ``Step`` until after second ``barrier.SignalAndWait();``.
3. ``Thread 1``: click ``Step`` until after ``barrier.SignalAndWait();`` opening the ``barrier`` for ``Thread 2``.
4. ``Thread 2``: click ``Step`` until after ``fireballCharge = 0;``.
5. ``Thread 0``: click ``Step`` until after ``Debug.Assert(false);``.

Accomplishment:

  It is highly recommended that you set the participant count to exactly the number of threads using the barrier in any real-world code.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Semaphores
==========

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Semaphores
++++++++++

1. ``Thread 0``: click ``Step`` until at ``ss.Wait();``.
2. ``Thread 1``: click ``Step`` until after ``ss.Release();`` in the ``else`` clause.
3. ``Thread 0``: click ``Step`` until at ``critical_section();``.
4. ``Thread 1``: click ``Step`` until at ``critical_section();`` (takes 2 iterations of the loop).

Race condition: both threads in the in same ``critical_section();``.

Solution:

1. Don't make a thread ``Release`` a ``Semaphore`` it didn't acquire.
2. Initialise the ``Semaphore`` with a ``count`` of ``1``.

Accomplishment:

  A few factories stopped but the Parallel Wizard is hard at work repairing them. You must move on and act quickly to capitalize on this.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Producer-Consumer
+++++++++++++++++

1. ``Thread 1``: click ``Step`` until at ``queue.Enqueue(new Dragon());``.
2. ``Thread 0``: click ``Step`` until at ``queue.Dequeue();``.

Accomplishment:

  Admittedly, this was not an extremely difficult producer-consumer pattern to exploit but you performed quite well nonetheless.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Producer-Consumer (variant)
+++++++++++++++++++++++++++

1. ``Thread 0``: click ``Step`` until at ``queue.Enqueue(new Golem());``.
2. ``Thread 0``: click ``Expand`` to see how the ``Enqueue`` is composed of atomic instructions.
3. ``Thread 0``: click ``Step`` until at ``queue returns to a consistent state.``.
4. ``Thread 1``: click ``Step`` until after ``queue.Dequeue();``.

Crash: tried to ``Dequeue`` from a ``queue`` that is in an invalid state.

Solution: lock the ``queue`` when performing non-atomic operations.

Accomplishment:

  Are you ready for the next challenge?

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Condition Variables
===================

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Condition Variables
+++++++++++++++++++

Try to ``Dequeue`` when there are no items.

This involves ``Thread 0`` and ``Thread 1`` to get into ``Monitor.Wait(mutex);`` at the same time and one performing the ``Dequeue`` before the other.

1. ``Thread 0``: click ``Step`` until at ``wait until woken up`` (after the ``Monitor.Wait(mutex);`` auto-expanded).
2. ``Thread 1``: click ``Step`` until at ``wait until woken up`` (after the ``Monitor.Wait(mutex);`` auto-expanded).
3. ``Thread 2``: click ``Step`` until after ``Monitor.PulseAll(mutex);`` and one item is in the ``queue``.
4. ``Thread 0``: click ``Step`` until at ``Monitor.Enter(mutex);`` inside ``Monitor.Wait(mutex);``
5. ``Thread 1``: click ``Step`` until at ``Monitor.Enter(mutex);`` inside ``Monitor.Wait(mutex);``
6. ``Thread 2``: click ``Step`` until after ``Monitor.Exit(mutex);``
7. ``Thread 0``: click ``Step`` until after ``Monitor.Exit(mutex);`` so the ``queue`` is empty and the mutex is free.
8. ``Thread 1``: click ``Step`` until after ``queue.Dequeue();``

Crash: tried to ``Dequeue`` from a queue that is empty.

Solution: use proper `condition variables <https://en.wikipedia.org/wiki/Monitor_(synchronization)#Condition_variables>`_
that encapsulate the condition and the monitor in one atomic operation.

Condition variable code for C# is at http://stackoverflow.com/questions/15657637/condition-variables-c-net and Delphi has built in ones in http://docwiki.embarcadero.com/Libraries/en/System.SyncObjs

A good explanation of using ``PulseAll`` versus ``Pulse`` is at http://stackoverflow.com/questions/6327278/monitor-wait-condition-variable/6331306#6331306

Accomplishment:

  Your skill is unmatched, Master Scheduler! Truly no program is safe before you

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

The Final Stretch
=================

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Dragonfire
++++++++++

You need the ``fireball`` to have at least a ``counter`` of  ``3`` as the ``Thread 0`` needs three ``fireball.Wait()`` calls to end up in the  ``critical_section();``.

1. ``Thread 0``: click ``Step`` until at ``c = c + 1;`` so the value of ``c`` is ``-1``.
2. ``Thread 1``: click ``Step`` until at ``critical_section();`` and ``fireball`` has a ``counter`` of  ``3``.
3. ``Thread 0``: click ``Step`` until at ``critical_section();``.

Race condition: both threads in the in same ``critical_section();``.

Solution: ensure variables shared by threads are locked over all changes.

Accomplishment:

  *But as you march on the Wizard's citadel, a catastrophe happens! Another dragon appeared on the horizon, and on its back, a fearsome sorcerer. Can you defeat them in the next challenge? You must - because if you don't, all that is simple in the world will soon exist no more.*

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Triple Danger
+++++++++++++

1. ``Thread 2``: click ``Step`` until at ``Monitor.Enter(conduit);``.
2. ``Thread 1``: click ``Step`` until after ``Monitor.Exit(conduit);`` and ``energyBursts`` is empty.
3. ``Thread 2``: click ``Step`` until at ``energyBursts.Dequeue();``.

Crash: tried to ``Dequeue`` from a queue that is empty.

Solution: perform the ``Count`` check within the ``Monitor.Enter()`` lock.

Accomplishment:

  *And now, the time has come to take the battle to the enemy - to fight the Parallel Wizard in his own land, in his very lair!*

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Boss Fight
++++++++++

Observing:

- ``Thread 1`` resets ``darkness`` and ``evil`` values to ``0`` at the end of each loop iteration
- ``Thread 1`` provides ``fortress.Release();`` in each loop iteration
  - ``Thread 0`` requires ``fortress`` to have a ``counter`` of at least ``2``
- ``Thread 0`` can only enter the ``if`` on a different condition than ``Thread 1`` can which means you have to fiddle with ``Expand`` so that both conditions are met:
  - ``Thread 0``: ``darkness != 2`` and ``evil != 2`` (easiest: ``darkness == 1`` and ``evil == 1``)
  - ``Thread 1``: ``darkness != 2`` and ``evil = 2``  (easiest: ``darkness == 1`` and ``evil == 2``)

Steps:

1. ``Thread 1``: click ``Step`` until at ``darkness++;`` for the 3rd time so ``fortress`` has a ``counter`` of ``2``.
2. ``Thread 1``: click ``Expand`` so ``darkness++`` gets expanded.
3. ``Thread 1``: click ``Step`` until at ``darkness = temp;`` so ``darkness`` still has a value ``0``.
4. ``Thread 0``: click ``Step`` until at ``if (fortress.Wait(500)) {`` with ``darkness`` having a value ``1`` and ``evil`` having a value ``1``.
5. ``Thread 1``: click ``Step`` until at ``Monitor.Enter(sanctum);`` with ``darkness`` having a value ``1`` and ``evil`` having a value ``2``.
6. ``Thread 0``: click ``Step`` until at ``Monitor.Enter(sanctum);`` with ``fortress`` having a ``counter`` of ``0`` (because of two ``fortress.Wait()`` calls
7. ``Thread 0``: click ``Step`` until at ``Monitor.Wait(sanctum);`` which automatically expands, releases the lock and ends up at ``wait until woken up``.
8. ``Thread 1``: click ``Step`` until at ``critical_section();`` so ``sanctum`` is not locked any more.
9. ``Thread 0``: click ``Step`` until at ``critical_section();``.

Crash: Two threads were in a critical section at the same time.

Accomplishment:

  **Congratulations!**

  *In the end...* **victory***!*

  *The Parallel Wizard is destroyed and his fortress crumbles at your feet. You have won. Never again will programmers over the world have to endure the difficulty of correct multithreaded programming because in defeating the Parallel Wizard, you have banished concurrency. The world will be as it was decades ago, with computer running at a reasonable speed and in the right order, as prescribed by the wise programmers.*

  *'Although,' you wonder, 'the tricks I used were somewhat useful... and I did feel quite a bit faster when parallelized. Perhaps there is something to this whole parallelism thing.'*

  *Indeed, perhaps there is, commander. Perhaps parallelism is useful, after all, Master Scheduler. The points you make are valid and maybe you should not be so quick to dismiss the advantages of parallelism and faster execution. After all, with the skills you gained fighting The Deadlock Empire, don't you think that you have become...*

  *...an even greater* **`Parallel Wizard`***?*

  Thank you, dear Scheduler, for playing The Deadlock Empire. We hope you had as much fun playing this game as we had making it. Concurrency programming is hard but it's also beautiful in a way and the world can always use more people learned in its ways. You are to be congratulated for making it this far. We are looking forward to the new software or games you will create using your knowledge of multithreading.

  You mastered all the lessons of The Deadlock Empire. Thank you for playing!
  Any thoughts about the game or ideas for improvement? We'd like to hear those! Just fill out
  `this form <http://goo.gl/forms/i05ukNUMmB>`_.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Demo time
#########

How does the Deadlock Empire work internally?
