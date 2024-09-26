void main() {
  /// Example demonstrating failure to adhere to the Liskov Substitution Principle (LSP).
  /// Here, we cannot replace a `Birds` object with its subclass `Penguin`, as it throws an exception.
  Birds sparrow = Sparrow();
  sparrow.fly(); // Works fine
  Birds penguin = Penguin();
  penguin.fly(); // Throws an exception

  ////////////////////////////

  /// Success in adhering to LSP.
  /// Here, we can easily replace the `Bird` superclass with its subclasses like `Eagle` and `Duck`,
  /// without breaking the program behavior.
  Bird eagle = Eagle();
  (eagle as FlyingBirds).fly();
  Bird duck = Duck();
  (duck as SwimmingBirds).swim();
}



///////////////////////////////////////////////////////////////////////////////////////

/// Example demonstrating the Liskov Substitution Principle (LSP).
/// LSP states that objects of a superclass should be replaceable with
/// objects of its subclasses without breaking the application.

/// This example violates LSP:
abstract class Birds {
  void fly();
}

class Sparrow extends Birds {
  @override
  void fly() {
    print('The sparrow is flying');
  }
}

class Penguin extends Birds {
  /// Here, the class Penguin violates LSP as it cannot be substituted
  /// for the parent class `Birds`.
  /// For example, Birds penguin = Penguin(); penguin.fly(); will throw an exception.
  @override
  void fly() {
    throw Exception('Penguins cannot fly');
  }
}

/// Adhering to LSP:
/// Refactor the design to follow LSP, separating behaviors.
abstract class Bird {
  void layEggs();
}

abstract class FlyingBirds extends Bird {
  @override
  void layEggs() {
    print('The bird is laying eggs');
  }

  void fly();
}

abstract class SwimmingBirds extends Bird {
  @override
  void layEggs() {
    print('The bird is laying eggs');
  }

  void swim();
}

class Eagle extends FlyingBirds {
  @override
  void fly() {
    print('The eagle is flying');
  }
}

class Duck extends SwimmingBirds {
  @override
  void swim() {
    print('The duck is swimming');
  }
}

