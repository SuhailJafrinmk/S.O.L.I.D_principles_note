///////////////////////////////////////////////////////////////////////////////////////
/// Open/Closed Principle (OCP)
/// The principle states that software entities (classes, modules, functions) should be 
/// open for extension but closed for modification. 
/// This means that we should be able to add new functionality to classes without altering 
/// the existing code, preventing regressions or breaking existing functionality.

///////////////////////////////////////////////////////////////////////////////////////
/// Example violating the Open/Closed Principle:
///
/// In this example, if we want to add new shapes, we have to modify the AreaCalculator class.
/// This breaks the OCP, as we are changing existing code whenever we need to extend functionality.

class AreaCalculatorWithoutOCP {
  /// This method calculates the total area based on specific shapes (Rectangle, Circle).
  /// If a new shape needs to be added, this method must be modified.
  /// This violates the OCP as it requires modifying existing code for new functionality.

  double getTotalAreaOfShapes(List<dynamic> shapes) {
    //if we want to add an additional shape we have to write additinal checks which violates OCP
    double totalArea=0.0;
    for(var shape in shapes){
      if(shape is RectangleWithoutOCP){
        totalArea +=shape.getArea();
      }else if(shape is CircleWithoutOCP){
        totalArea +=shape.getArea();
      }
    }
    return totalArea;
  }
}

class RectangleWithoutOCP {
  final double height;
  final double width;
  RectangleWithoutOCP({required this.height, required this.width});
  double getArea() => height * width;
}

class CircleWithoutOCP {
  final double radius;
  CircleWithoutOCP({required this.radius});
  double getArea() => 3.14 * radius * radius;
}

void main() {
  RectangleWithoutOCP rectangle = RectangleWithoutOCP(height: 10.0, width: 5.0);
  CircleWithoutOCP circle = CircleWithoutOCP(radius: 3.0);

  AreaCalculatorWithoutOCP calculator = AreaCalculatorWithoutOCP();
  
  /// Adding new shapes would require modifying the AreaCalculatorWithoutOCP class.
  double totalArea = calculator.getTotalAreaOfShapes(rectangle) + 
                     calculator.getTotalAreaOfShapes(circle);
  print('Total Area without OCP: $totalArea');
}

///////////////////////////////////////////////////////////////////////////////////////
/// Correct Implementation adhering to the Open/Closed Principle (OCP):
///
/// Now, we follow the OCP by introducing an abstract class `Shapes` and making
/// each shape responsible for calculating its own area. This makes the AreaCalculator
/// class open for extension but closed for modification when adding new shapes.

abstract class Shapes {
  /// Each shape must implement this method to calculate its total area.
  double getTotalArea();
}

class Rectangle extends Shapes {
  final double height;
  final double width;
  
  Rectangle({required this.height, required this.width});

  @override
  double getTotalArea() {
    /// The area of a rectangle is calculated as height * width.
    return height * width;
  }
}

class Circle extends Shapes {
  final double radius;
  
  Circle({required this.radius});

  @override
  double getTotalArea() {
    /// The area of a circle is calculated as π * radius².
    return 3.14 * radius * radius;
  }
}

class AreaCalculator {
  /// This method calculates the total area of multiple shapes.
  /// It is closed for modification but can handle new shape types
  /// because each shape class is responsible for its own area calculation.
  
  double getTotalAreasOfShapes(List<Shapes> shapes) {
    double totalArea = 0.0;
    
    /// Loop through all shapes and accumulate their areas.
    for (var shape in shapes) {
      totalArea += shape.getTotalArea();
    }
    return totalArea;
  }
}

/// Example usage:
void main() {
  Rectangle rectangle = Rectangle(height: 10.0, width: 5.0);
  Circle circle = Circle(radius: 3.0);

  AreaCalculator calculator = AreaCalculator();

  /// Here we can calculate the total area of multiple shapes.
  double totalArea = calculator.getTotalAreasOfShapes([rectangle, circle]);
  print('Total Area with OCP: $totalArea');
}
