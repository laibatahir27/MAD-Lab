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

abstract class LibraryItem {
  final String title;
  final int year;

  LibraryItem(this.title, this.year);

  String describe() => '$title ($year)';

  int lateFee(int days);
}

abstract class Borrowable {
  bool get isAvailable;
  void borrow();
  void giveBack();
}

mixin Renewable {
  int renewals = 0;

  bool renew(int limit) {
    if (renewals >= limit) {
      return false;
    }
    renewals++;
    return true;
  }
}

class Book extends LibraryItem with Renewable implements Borrowable {
  final int pages;
  bool _out = false;

  Book(super.title, super.year, this.pages);

  @override
  String describe() => '${super.describe()}, $pages pages';

  @override
  int lateFee(int days) => days * feePerDay;

  @override
  bool get isAvailable => !_out;

  @override
  void borrow() {
    _out = true;
  }

  @override
  void giveBack() {
    _out = false;
  }
}

class Magazine extends LibraryItem {
  final int issue;

  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';

  @override
  int lateFee(int days) => days * (feePerDay ~/ 2);
}

class Dvd extends LibraryItem with Renewable {
  final int minutes;

  Dvd(super.title, super.year, this.minutes);

  @override
  String describe() => '${super.describe()}, $minutes min';

  @override
  int lateFee(int days) => days * feePerDay * 2;
}

Book mainBook() {
  return Book(titles[u], yearOf(u), 100 + 3 * seed);
}

Magazine mainMagazine() {
  int i = (u + 1) % 10;
  return Magazine(titles[i], yearOf(i), 1 + (t + u) % 12);
}

Dvd mainDvd() {
  int i = (u + 2) % 10;
  return Dvd(titles[i], yearOf(i), 90 + seed % 40);
}

enum MemberType {
  student(3, 50),
  faculty(10, 20),
  guest(1, 0);

  final int maxLoans;
  final int discountPercent;

  const MemberType(this.maxLoans, this.discountPercent);

  int applyDiscount(int fee) => fee - (fee * discountPercent) ~/ 100;
}

extension MoneyText on int {
  String get rs => 'Rs $this';
}

extension Initials on String {
  String get initials => split(' ').map((w) => w[0]).join();
}

extension ShelfMath on List<LibraryItem> {
  int totalLateFee(int days) {
    return fold(0, (sum, item) => sum + item.lateFee(days));
  }
}

class Fine {
  final int amount;

  const Fine(this.amount);

  Fine operator +(Fine o) => Fine(amount + o.amount);

  bool operator >(Fine o) => amount > o.amount;

  @override
  bool operator ==(Object other) {
    return other is Fine && other.amount == amount;
  }

  @override
  int get hashCode => amount.hashCode;

  @override
  String toString() => 'Fine($amount)';
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

  // Think: item.pages gives a compile error because the variable type is
  // LibraryItem and LibraryItem does not have pages. Dart checks the
  // variable type at compile time, not the real object type.
}

void step2() {
  print('--- Step 2 ---');
  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');

  // Think: without @override, a typo like descibe() just makes a new method.
  // No error, and the old describe() keeps running, so pages/issue is missing.
}

void step3() {
  print('--- Step 3 ---');
  print('Step 3: Book late fee for $daysLate days = ${mainBook().lateFee(daysLate)}');
  print('Step 3: Magazine late fee for $daysLate days = ${mainMagazine().lateFee(daysLate)}');
  print('Step 3: Dvd late fee for $daysLate days = ${mainDvd().lateFee(daysLate)}');

  // Think: LibraryItem('x', 2000) gives an error because the class is
  // abstract. lateFee has no body, so there would be nothing to run.
}

void step4() {
  print('--- Step 4 ---');
  Book book = mainBook();
  print('Step 4: available? ${book.isAvailable}');
  book.borrow();
  print('Step 4: after borrow? ${book.isAvailable}');
  book.giveBack();
  print('Step 4: after return? ${book.isAvailable}');

  List<LibraryItem> items = [book, mainMagazine(), mainDvd()];
  for (LibraryItem item in items) {
    print('Step 4: ${item.runtimeType} borrowable? ${item is Borrowable}');
  }

  // Think: extends would give me ready-made code from Borrowable, but it
  // has no code, only a promise. Also Book already has one parent, and
  // Dart allows only one extends.
}

void step5() {
  print('--- Step 5 ---');
  Book book = mainBook();
  int ok = 0;
  for (int n = 0; n < renewAttempts; n++) {
    if (book.renew(renewLimit)) {
      ok++;
    }
  }
  print('Step 5: renewed $ok of $renewAttempts attempts (limit $renewLimit)');
  print('Step 5: renew once more? ${book.renew(renewLimit)}');
  print('Step 5: dvd can renew too? ${mainDvd().renew(1)}');

  // Think: if renew was in LibraryItem, Magazine would get it too. A mixin
  // lets me add it only to Book and Dvd.
}

void step6() {
  print('--- Step 6 ---');
  MemberType type = MemberType.values[seed % 3];
  int fee = mainBook().lateFee(daysLate);
  print('Step 6: member type = ${type.name} (index ${type.index})');
  print('Step 6: max loans = ${type.maxLoans}');
  print('Step 6: book fee $fee -> ${type.applyDiscount(fee)} after discount');

  // Think: if I mistype MemberType.studnet, Dart shows an error right away.
  // A string like 'studnet' gives no error and fails later.
}

void step7() {
  print('--- Step 7 ---');
  MemberType type = MemberType.values[seed % 3];
  int discounted = type.applyDiscount(mainBook().lateFee(daysLate));
  print('Step 7: ${discounted.rs}');
  print('Step 7: initials of "${titles[u]}" = ${titles[u].initials}');

  List<LibraryItem> shelf = [mainBook(), mainMagazine(), mainDvd()];
  print('Step 7: shelf fee for $daysLate days = ${shelf.totalLateFee(daysLate).rs}');

  // Think: 72.rs is easier to read and write than rs(72), and it shows up
  // in autocomplete when I type a dot after the number.
}

void step8() {
  print('--- Step 8 ---');
  Fine f1 = Fine(mainBook().lateFee(daysLate));
  Fine f2 = Fine(mainMagazine().lateFee(daysLate));
  print('Step 8: $f1 + $f2 = ${f1 + f2}');
  print('Step 8: first bigger? ${f1 > f2}');
  print('Step 8: equal copies? ${f1 == Fine(f1.amount)}');
  print('Step 8: set size = ${{f1, Fine(f1.amount), f2}.length}');

  // Think: without hashCode the set size becomes 3. A Set checks hashCode
  // first so two equal Fines with different hash codes are never compared.That's why == and hashCode are written together.
}

void step9() {
  print('--- Step 9 ---');
}

void step10() {
  print('--- Step 10 ---');
}