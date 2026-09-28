// Week3.dart - Library Desk Assistant
// Name: Laiba Tahir Roll no: 04072313014

final List<Map<String, dynamic>> books = [
  {
    'title': 'Dart in Action',
    'author': 'Ada',
    'year': 2021,
    'copies': 3,
    'tags': ['dart', 'programming'],
  },
  {
    'title': 'Flutter Basics',
    'author': 'Sam',
    'year': 2023,
    'copies': 0,
    'tags': ['flutter', 'mobile'],
  },
  {
    'title': 'Clean Code',
    'author': 'Martin',
    'year': 2008,
    'copies': 2,
    'tags': ['programming', 'design'],
  },
  {
    'title': 'Algorithms',
    'author': 'Knuth',
    'year': 1968,
    'copies': 1,
    'tags': ['programming', 'math'],
  },
  {
    'title': 'UI Design',
    'author': 'Nora',
    'year': 2019,
    'copies': 4,
    'tags': ['design', 'mobile'],
  },
];

//Part 1

//Task 1.1: Positional parameters
double lateFee(int daysLate, double ratePerDay) => daysLate * ratePerDay;

//Task 1.2: Optional positional parameter
String formatTitle(String title, [String? author]) {
  if (author == null) {
    return title;
  }

  return '$title by $author';
}

//Task 1.3: Named parameters with required and a default
Map<String, dynamic> makeBook({
  required String title,
  required String author,
  int year = 2024,
  int copies = 1,
}) {
  return {'title': title, 'author': author, 'year': year, 'copies': copies};
}

//Task 1.4: Arrow function
bool isClassic(int year) => year < 2000;

//Part 2 functions

//Task 2.1: Passing a function as an argument
List<String> transformAll(List<String> items, String Function(String) fn) {
  List<String> result = [];
  for (var item in items) {
    result.add(fn(item));
  }
  return result;
}

//Task 2.2: A closure that remembers
int Function() makeCounter() {
  int count = 0;
  return () {
    count++;
    return count;
  };
}

//Task 2.3: A closure with a parameter
double Function(int) makeFeeCalculator(double rate) {
  return (int days) => days * rate;
}

//Task 2.4: Recursion
int sumDigits(int n) {
  if (n < 10) {
    return n;
  }
  return (n % 10) + sumDigits(n ~/ 10);
}

//Part 3

//Task 3.4: Map
Map<String, int> buildStock() {
  return {
    for (var book in books) book['title'] as String: book['copies'] as int,
  };
}

//Part 4

//Task 4.1: A generic class
class Box<T> {
  T value;
  Box(this.value);
}

//Task 4.2: A generic function
T firstOr<T>(List<T> items, T fallback) {
  if (items.isEmpty) {
    return fallback;
  }
  return items.first;
}

//Task 4.3: A class with two type parameters
class Pair<A, B> {
  final A first;
  final B second;
  Pair(this.first, this.second);

  @override
  String toString() => '($first, $second)';
}

//Part 5

//Task 5.1: Custom exceptions
class BookNotFoundException implements Exception {
  final String title; 
  BookNotFoundException(this.title);
}

class BookNotAvailableException implements Exception {
  final String title;
  BookNotAvailableException(this.title);
}

//Task 5.2: Throwing
void checkOut(Map<String, int> stock, String title) {
  if (!stock.containsKey(title)) {   //  title is not a key in stock
    throw BookNotFoundException(title);
  }

  else if (stock[title]! <= 0) {  //  count is 0 (or less)
    throw BookNotAvailableException(title);
  }
  
  else{
  stock[title] = stock[title]! - 1;   // decrease the count by one
  }
}

//Task 5.4: A built-in exception
Map<String, dynamic> findBook(String title) {
  return books.firstWhere((book) => book['title'] == title);
}

//Part 6

//Task 6.1: Await a Future
Future<String> fetchBookOfTheDay() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Dart in Action';
}

//Task 6.3: Errors in async code
Future<String> fetchBroken() async {
  await Future.delayed(Duration(milliseconds: 500));
  throw Exception('Server down');
}

//main function

void main() async {
  part1();
  part2();
  part3();
  part4();
  part5();
  await part6();
}

void part1() {
  print('--- Part 1 ---');
  print('Late fee: ${lateFee(5, 0.5)}');
  print(formatTitle('Dart in Action'));
  print(formatTitle('Dart in Action', 'Ada'));
  print(makeBook(title: 'Clean Code', author: 'Martin'));
  print(makeBook(title: 'Algorithms', author: 'Knuth', year: 1968));
  print(isClassic(1968));
  print(isClassic(2021));
}

void part2() {
  print('--- Part 2 ---');
  var items = ['Dart in Action', 'Clean Code'];

  // anonymous function
  print(
    transformAll(items, (s) {
      return s.toUpperCase();
    }),
  );
  // arrow function
  print(transformAll(items, (s) => '$s!'));

  var desk1 = makeCounter();
  var desk2 = makeCounter();
  print(desk1());
  print(desk1());
  print(desk1());
  print(desk2());

  var studentFee = makeFeeCalculator(0.25);
  var staffFee = makeFeeCalculator(0.10);
  print('Student fee: ${studentFee(4)}');
  print('Staff fee: ${staffFee(4)}');

  print('Sum of digits: ${sumDigits(1223)}');
}

void part3() {
  print('--- Part 3 ---');

  //Task 3.1: map and where
  var titles = books.map((book) => book['title'] as String).toList();
  print('Titles: $titles');

  var available = books
      .where((book) => (book['copies'] as int) > 0)
      .map((book) => book['title'] as String)
      .toList();

  print('Available: $available');

  //Task 3.2: reduce and fold
  int totalCopies = books.fold(0, (sum, book) => sum + (book['copies'] as int));
  print('Total copies: $totalCopies');

  var years = books.map((book) => book['year'] as int).toList();
  int oldest = years.reduce((x, y) => x < y ? x : y);
  print('Oldest year: $oldest');

  //Task 3.3: Sorting without damaging the original
  var sortedBooks = List.of(books);
  sortedBooks.sort((x, y) => (x['year'] as int).compareTo(y['year'] as int));
  var sortedTitles = sortedBooks.map((book) => book['title']).toList();
  print('By year: $sortedTitles');

  //Task 3.4: Map
  var stock = buildStock();
  print('Stock: $stock');
  stock.forEach((title, copies) {
    if (copies == 0) {
      print('Out of stock: $title');
    }
  });

  print('Copies of Unknown: ${stock['Unknown'] ?? 0}');

  //Task 3.5: Set
  Set<String> allTags = {
    for (var book in books) ...(book['tags'] as List<String>),
  };
  print('All tags: $allTags');

  var a = {'Dart in Action', 'Clean Code', 'Flutter Basics'};
  var b = {'Clean Code', 'Flutter Basics', 'Algorithms'};
  print('Union: ${a.union(b)}');
  print('Common: ${a.intersection(b)}');
  print('Only in A: ${a.difference(b)}');
}

void part4() {
  print('--- Part 4 ---');

  //Task 4.1: A generic class
  var intBox = Box<int>(5);
  var strBox = Box<String>('dart');
  print('Box<int>: ${intBox.value}');
  print('Box<String>: ${strBox.value}');
  // intBox.value='hello'; //compile time error:String can't be assigned to int data type

  //Task 4.2: A generic function
  print(firstOr(['Dart in Action', 'Clean Code'], 'none'));
  print(firstOr<String>([], 'z'));

  //Task 4.3: A class with two type parameters
  print(Pair('Dart in Action', 3));
}

void part5() {
  print('--- Part 5 ---');

  //Task 5.3: try / on / catch / finally
  var stock = buildStock();

  for (var title in ['Dart in Action', 'Flutter Basics', 'Unknown Book']) {
    try {
      checkOut(stock, title);
      print('Checked out: $title');
    } on BookNotFoundException catch (e) {
      print('Not found: "${e.title}"');
    } on BookNotAvailableException catch (e) {
      print('Sorry: "${e.title}" has no copies left');
    } finally {
      print('Transaction logged.');
    }
  }
  print('Copies left of Dart in Action: ${stock['Dart in Action']}');

  //Task 5.4: A built-in exception
  try {
    findBook('Missing');
  } on StateError {
    print('Search failed: no such book');
  }
}

Future<void> part6() async {
  print('--- Part 6 ---');

  //Task 6.1: Await a Future
  print('Fetching...');
  var book = await fetchBookOfTheDay();
  print('Book of the day: $book');

  //Task 6.3: Errors in async code
  try {
    await fetchBroken();
  } catch (e) {
    print('Fetch failed: $e');
  }
}

// ---------------- Reflection answers ----------------
// 1.I use fold when I want to give my own starting value or when the list can be empty because reduce gives an error on an empty list.
// 2. Capture means the inner function remembers a variable of the outer function even after the outer function is finished. In makeCounter,
//    the variable count was captured.
// 3.Dart checks the clauses one by one from the top.catch (e) catches every error so if it is first then  BookNotAvailableException will never run.
// 4.It still compiles because a Future is a normal object But without await we get the Future itself and not the value so its output is wrong.
