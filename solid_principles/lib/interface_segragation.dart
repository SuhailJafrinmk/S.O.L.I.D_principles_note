/// INTERFACE SEGREGATION PRINCIPLE (ISP):
/// States that no client should be forced to implement methods it does not need.
/// This prevents bloated interfaces and encourages smaller, more specific interfaces.

/// First, let's look at an example that violates the Interface Segregation Principle:
abstract class Car {
  void pedal();
  void fuel();  // Not all cars need fuel (e.g., electric cars), which is problematic.
}

class Innova implements Car {
  @override
  void pedal() {
    print('Innova pedals');
  }
  
  @override
  void fuel() {
    print('Fuel is petrol');
  }
}

/// Problem: Even though Tesla doesn't use fuel, we're forced to implement the fuel() method.
/// This violates ISP because Tesla shouldn't depend on a method it doesn't use.
class Tesla implements Car {
  @override
  void pedal() {
    print('Tesla pedals');
  }

  @override
  void fuel() {
    /// This shouldn't be allowed for electric cars, yet we are forced to implement it.
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

/// To follow the Interface Segregation Principle, we break down Car into smaller, more specific interfaces:
abstract class Truck {
  void pedal();
}

abstract class Fuel {
  void addFuel(); // Specific to vehicles that require fuel.
}

abstract class Electric {
  void plugInCharge(); // Specific to electric vehicles.
}

/// Now we can have vehicles implement only the interfaces they need:
class MercedezTruck implements Truck, Fuel {
  @override
  void pedal() {
    print('The truck is pedalling');
  }

  @override
  void addFuel() {
    print('The truck is adding fuel at the station');
  }
}

/// In contrast, TeslaTruck implements only what it needs: pedal and charging
class TeslaTruck implements Truck, Electric {
  @override
  void pedal() {
    print('The Tesla truck is pedalling');
  }

  @override
  void plugInCharge() {
    print('Tesla truck is charging at the station');
  }
}

/// Benefits of this design:
/// - TeslaTruck is not forced to implement methods that are irrelevant to its functionality.
/// - Each class adheres to the Interface Segregation Principle, making the code more modular and easier to maintain.
