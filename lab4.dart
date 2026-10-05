// lab3.dart - Campus Cafe Order System
// Name: Laiba Tahir Roll no: 04072313014
const String rollNo = '04072313014';

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit
const List<String> menu = [
  'Chai',
  'Latte',
  'Mocha',
  'Samosa',
  'Brownie',
  'Sandwich',
  'Cold Coffee',
  'Fries',
  'Pakora',
  'Zinger Wrap',
];
int priceOf(int i) => 100 + 7 * i + 3 * t; // price of menu[i], in rupees
final int priceFloor = 60 + 5 * t;
final int taxPercent = 5 + t;
final int bigOrderLimit = 450 + 20 * t;
final int balanceCap = 600 + 20 * t;
final int couponPercent = 5 + t + u;
// ===========================================================================

// Task 1.1 class
class Dish {
  late String name;
  late int price;
}

//Task 2.1 class
class MenuItem {
  String name;
  int price;
  MenuItem(this.name, this.price) {
    if (this.price < priceFloor) {
      //Task 2.2
      this.price = priceFloor;
    }
  }
  // Think 2: price is not final because the cons body changes it again (to priceFloor) after it is first set.
  MenuItem.free(this.name) : price = 0; //Task 3.1

  // Think 3: the floor check is in the main constructor's body and free() never uses that body.
  //Task 3.2
  MenuItem.fromString(String text)
    : name = text.split(':')[0],
      price = int.parse(text.split(':')[1]);
}

//Task 4.1 class
class OrderLog {
  // Think 4: the underscore makes them private so no other file can create a second log.
  static OrderLog? _instance;
  final List<String> entries = [];
  OrderLog._internal();
  factory OrderLog() {
    return _instance ??= OrderLog._internal();
  }
  void add(String msg) => entries.add(msg);
}

//Task 5.1 class
class OrderLine {
  final MenuItem item;
  final int qty;
  final int total;
  final int tax;
  // Think 5: the object is not fully built while the initializer list runs so it cannot read total.We use item and qty instead.
  OrderLine(this.item, this.qty)
    : total = item.price * qty,
      tax = (item.price * qty * taxPercent) ~/ 100,
      assert(qty > 0, 'qty must be positive');
  // Think 6: grand = 5 fails because grand is only a getter.A setter is needed.

  //Task 6.1
  int get grand => total + tax;
  bool get isBigOrder => grand > bigOrderLimit;
  String get label => '${item.name} x$qty';
}

//Task 5.2
OrderLine mainOrder() {
  return OrderLine(MenuItem(menu[u], priceOf(u)), 2 + (t + u) % 5);
}

//Task 7.1 class
class StudentCard {
  final String owner;
  int _balance;
  StudentCard(this.owner) : _balance = 0;
  int get balance => _balance;
  // Think 7: a setter could also throw an error for a bad value.
  set balance(int v) {
    if (v < 0) {
      _balance = 0;
    } else if (v > balanceCap) {
      _balance = balanceCap;
    } else {
      _balance = v;
    }
  }
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

//step1 function
void step1() {
  print('--- Step 1 ---');
  var item1 = Dish();
  item1.name = menu[u];
  item1.price = priceOf(u);
  var item2 = Dish();
  item2.name = menu[(u + 1) % 10];
  item2.price = priceOf((u + 1) % 10);
  item2.price = item2.price - u;
  print('Step 1: ${item1.name} Rs ${item1.price}');
  print('Step 1: ${item2.name} Rs ${item2.price}');
}

//step2 function
void step2() {
  print('--- Step 2 ---');
  //Task 2.3
  var a = MenuItem(menu[u], priceOf(u));
  var b = MenuItem('Test Special', 15 * u);
  print('Step 2: ${a.name} Rs ${a.price}');
  print('Step 2: Test Special Rs ${b.price}');
}

//step3 function
void step3() {
  print('--- Step 3 ---');
  //Task 3.3
  var freebie = MenuItem.free('Water');
  int i = (u + 2) % 10;
  var parsed = MenuItem.fromString('${menu[i]}:${priceOf(i)}');
  print('Step 3: ${freebie.name} Rs ${freebie.price}');
  print('Step 3: ${parsed.name} Rs ${parsed.price}');
  print('Step 3: floor=$priceFloor, free price=${freebie.price}');
}

//step4 function
void step4() {
  print('--- Step 4 ---');
  //Task 4.2
  var log1 = OrderLog();
  var log2 = OrderLog();
  for (int i = 1; i <= u + 2; i++) {
    String msg = 'order #${100 * t + i}';
    if (i % 2 == 1) {
      log1.add(msg);
    } else {
      log2.add(msg);
    }
  }
  print('Step 4: same object? ${identical(log1, log2)}');
  print('Step 4: entries = ${log1.entries.length}');
  print('Step 4: last = ${log2.entries.last}');
}

//step5 function
void step5() {
  print('--- Step 5 ---');
  //Task 5.3
  var line = mainOrder();
  print('Step 5: ${line.item.name} x${line.qty}');
  print('Step 5: total=${line.total} tax=${line.tax}');
  try {
    OrderLine(line.item, 0);
    print('Step 5: assert did NOT fire');
  } on AssertionError {
    print('Step 5: assert fired');
  }
}

//step6 function
void step6() {
  print('--- Step 6 ---');
  //Task 6.2
  var line = mainOrder();
  print('Step 6: grand=${line.grand}');
  print('Step 6: big order? ${line.isBigOrder} (limit $bigOrderLimit)');
  print('Step 6: label=${line.label}');
}

//step7 function
void step7() {
  print('--- Step 7 ---');
  var card = StudentCard('S$seed');
  card.balance = seed * 10 + 50;
  print('Step 7: topped up -> ${card.balance}');
  card.balance = -seed - 1;
  print('Step 7: bad value -> ${card.balance}');
  card.balance = balanceCap - u;
  print('Step 7: reset -> ${card.balance}');
  card.balance = card.balance - mainOrder().grand;
  print('Step 7: paid order -> ${card.balance}');
}

void step8() {
  print('--- Step 8 ---');
}

void step9() {
  print('--- Step 9 ---');
}

void step10() {
  print('--- Step 10 ---');
}
