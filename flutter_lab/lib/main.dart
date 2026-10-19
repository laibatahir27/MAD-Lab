import 'package:flutter/material.dart';

const String studentName = 'Samina Shahid';
const String rollNo = '04072313018';

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10;
final int u = seed % 10;

const List<String> courses = [
  'Mobile Dev',
  'Data Structures',
  'Operating Systems',
  'Databases',
  'Networks',
  'Software Eng',
  'AI',
  'Web Engineering',
  'Graphics',
  'Security',
];

final String course = courses[u];
final int startCount = 3 + u;
final int stepSize = 1 + t % 4;
final int maxCount = 20 + 2 * t;
final int startSeconds = 5 + (t + u) % 6;
final int bugStep = 1 + u % 4;
// ===========================================================================

// Step 9 writes to this list from initState and dispose.
final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

// Step 1 answer:
// runApp() receives LabApp, the root widget of the application.
// MaterialApp's home property specifies the first page, HomePage.

class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Study Tracker',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Tracker: $course'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StudentCard(
              name: studentName,
              roll: rollNo,
              course: course,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Start: $startCount',
                  key: const Key('info-start'),
                ),
                Text(
                  'Step: $stepSize',
                  key: const Key('info-step'),
                ),
                Text(
                  'Max: $maxCount',
                  key: const Key('info-max'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            GoalBanner(
              count: startCount,
              max: maxCount,
            ),
          ],
        ),
      ),
    );
  }
}

class StudentCard extends StatelessWidget {
  final String name;
  final String roll;
  final String course;

  const StudentCard({
    super.key,
    required this.name,
    required this.roll,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $name',
              key: const Key('student-name'),
            ),
            Text(
              'Roll no: $roll',
              key: const Key('student-roll'),
            ),
            Text(
              'Course: $course',
              key: const Key('student-course'),
            ),
          ],
        ),
      ),
    );
  }
}

// Step 4: GoalBanner displays the count, maximum, and percentage.
class GoalBanner extends StatelessWidget {
  final int count;
  final int max;

  const GoalBanner({
    super.key,
    required this.count,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    final percent = count * 100 ~/ max;

    return Text(
      'Progress: $count of $max ($percent%)',
      key: const Key('progress'),
    );
  }
}

// Step 4 answer:
// GoalBanner does not need setState because it only displays values received through its constructor and does not manage changing state.


// ---- Provided for Step 7. It has a bug on purpose. Do not rename anything.
class BuggyCounter extends StatefulWidget {
  const BuggyCounter({super.key});

  @override
  State<BuggyCounter> createState() => _BuggyCounterState();
}

class _BuggyCounterState extends State<BuggyCounter> {
  int _clicks = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Bug clicks: $_clicks',
          key: const Key('bug-text'),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          key: const Key('bug-button'),
          onPressed: () {
            _clicks += bugStep;
          },
          child: Text('+$bugStep'),
        ),
      ],
    );
  }
}