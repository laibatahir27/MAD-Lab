# Flutter Lab: Study Tracker (CS442)

Name: Laiba Tahir
Roll no: 04072313014

A1: 8
A2: 11
A3: 3
A4: 31

B1: Stateless classes are LabApp, HomePage, StudentCard and GoalBanner. They only show the data they are given and nothing in them changes. Stateful classes are Tally, BuggyCounter and Countdown, because their values change (count, clicks, seconds left, builds), so they need a State object to keep that data.

B2: The Timer keeps running even after the widget is removed. If I do not cancel it in dispose(), it will keep calling setState() on a widget that is gone and give an error. It also wastes memory.

B3: LabApp(), HomePage(), Tally(), Countdown(), BuggyCounter(), the SizedBox widgets and Text('Reset') can be const because they never change. const means Flutter makes the widget once and reuses it, so it does not rebuild it again and again.