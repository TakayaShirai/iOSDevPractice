///// Factory: A component responsible solely for the wholesale (not piecewise) creation of objects
///// This design patter is useful in a situation like objection creation logics becomes too convoluted or Initialized is not descriptive.
//
//import Foundation
//
//class Point: CustomStringConvertible {
//  private var x, y: Double
//
//  private init(x: Double, y: Double) {
//    self.x = x
//    self.y = y
//  }
//
//  /// This is not bad, but we wanna have more information about what kind of initialization we're doing.
//  /// And the problem with initializers is the name that you use for calling as the initializer is always the name of the class, which we're going to call.
//  /// This is the part of the reason factories exist in the first place. Factories are a lot more flexible in terms of naming.
//  private init(rho: Double, theta: Double) {
//    x = rho * cos(theta)
//    y = rho * sin(theta)
//  }
//
//  var description: String {
//    return "(x = \(x), y = \(y))"
//  }
//
//  static let factory = PointFactory.instance
//
//  /// This is the inner factory. Users can't make their own factories.
//  class PointFactory {
//    private init() {}
//
//    static let instance = PointFactory()
//
//    func createCartesian(x: Double, y: Double) -> Point {
//      return Point(x: x, y: y)
//    }
//
//    func createPolar(rho: Double, theta: Double) -> Point {
//      return Point(rho: rho, theta: theta)
//    }
//  }
//}
//
//func main() {
//  let p = Point.factory.createPolar(rho: 1, theta: 2)
//  print(p)
//}
//
//main()
