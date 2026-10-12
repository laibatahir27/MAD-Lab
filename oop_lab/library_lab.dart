// library_lab.dart - Campus Library System
// Name: Laiba Tahir Roll no: 04072313014
const String rollNo = '04072313014'; // e.g. '21F-0347'
// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit
const List<String> titles = [
  'Dart Basics', 'Flutter In Action', 'Data Structures', 'Operating Systems',
  'Mobile Design', 'Clean Code', 'Algorithms Unlocked', 'Computer Networks',
  'Database Systems', 'Software Testing',
];
int yearOf(int i) => 1995 + 2 * i + t; // publication year of titles[i]
final int feePerDay = 5 + t; // late fee per day, in rupees
final int daysLate = 3 + (t + u) % 6; // normal number of days late
final int daysBig = 10 + u; // a long overdue period
final int feeCap = 150 + 10 * t; // no single fee may exceed this
final int renewLimit = 1 + t % 3; // renewals allowed per item
final int renewAttempts = 2 + u; // renewal attempts made in Step 5
final int shelfSize = 3 + u % 4; // items on the shelf in Steps 9-10
// ===========================================================================

// Parent class
class LibraryItem {
  final String title;
  final int year;

  LibraryItem(this.title, this.year);
}

// Book gets title and year from LibraryItem and adds pages
class Book extends LibraryItem {
  final int pages;

  Book(super.title, super.year, this.pages);
}

Book mainBook() {
  return Book(titles[u], yearOf(u), 100 + 3 * seed);
}

void main() {
  print('Seed: $seed (t=$t, u=$u)');
  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
  step10();
}

void step1() {
  print('--- Step 1 ---');
  Book b = mainBook();
  LibraryItem item = b;
  print('Step 1: ${b.title} (${b.year}), ${b.pages} pages');
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');

  // Think:item.pages gives a compile error beacuse the variable type is
  // LibraryItem and LibraryItem does not have pages Dart checks the variable
  // type at compile time not the real object type.the object is a Book but
  // the compiler only sees LibraryItem.
}

void step2() { print('--- Step 2 ---'); }
void step3() { print('--- Step 3 ---'); }
void step4() { print('--- Step 4 ---'); }
void step5() { print('--- Step 5 ---'); }
void step6() { print('--- Step 6 ---'); }
void step7() { print('--- Step 7 ---'); }
void step8() { print('--- Step 8 ---'); }
void step9() { print('--- Step 9 ---'); }
void step10() { print('--- Step 10 ---'); }