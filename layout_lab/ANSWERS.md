# Layout Lab: Team Board

Name: Laiba Tahir
Roll no: 04072313014

A1: 18
A2: 5
A3: 3
A4: 66

B1: Stateless: LabApp, HomePage, SettingsCard, SummaryRow, Probe, Welcome, InfoPanel, ShareRow, InfoBox, StampStack. These only show data that comes from constants or from their parent and never change by themselves. Stateful: Clock (it owns a Timer and the changing seconds and build counter), Tile (it owns its own taps counter), SwapBoard (it owns the list of tiles that is reversed on Swap). These three need State that survives rebuilds.

B2: The Widget is rebuilt (a new object) on every setState. The Element and the RenderObject are kept and only updated. Probe showed this: its Widget number changed every second, but its Element number stayed the same. The Element is what keeps the State, and the RenderObject does the layout and painting.

B3: In Step 7 the Row passes constraints down to its children. A plain Row gives each Text unlimited width, so each Text becomes as wide as its full single line and the sizes sum to more than the screen, which causes overflow. With Expanded, the Row gives each Text a tight width (one third of the Row), so the Text must fit that width and wraps onto several lines. Then the sizes go back up: each Text reports a height that fits its wrapped lines, and the Row takes the tallest one as its own height.
