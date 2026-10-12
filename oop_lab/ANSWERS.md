# OOP Lab Answers

Name: Laiba Tahir
Roll no: 04072313014

Q1. What can a subclass using extends use for free that a class using implements has to write itself?

When a class uses extends, it directly gets the fields and the working methods of the parent class, so I don't have to write them again. With implements I only get the names of the methods, and I have to write the full code of every method myself.

Q2. Book and Dvd both use Renewable. When would you pick a mixin, and when an abstract parent class?

I use a mixin when I want to give the same code to some classes that are not related, like Book and Dvd but not Magazine. I use an abstract parent class when all the classes are the same kind of thing and every one of them must follow the same rules.

Q3. Why must you override hashCode whenever you override ==?

A Set or Map looks at hashCode first to find an object. If two objects are equal by == but have different hash codes, Dart can treat them as different objects. So both should be changed together.

Q4. An extension method on String and a subclass of String both add behaviour. Why does Dart let you write the first one but not the second?

String is a final class in Dart, so nobody is allowed to extend it. An extension doesn't make a new class, it just adds a new method to the String that already exists.