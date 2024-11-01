///// Motivation:
///// You are calling foo.Bar(). This assumes that foo is in the same process as Bar()
///// What if, later on, you want to put all Foo-related operatiions into a seperate process
/////   - Can you avoid changing your code?
/////  Proxy to the rescue
/////   - Same interface, extirely different behavior
/////   This is called a communication proxy
/////   - Other types: logging, virtual, guarding
/////
///// Proxy: A class that functions as an interface to a particular resource. That resource may be remote, expensive to construct,
/////      or may require logging or some other added functionality.
///
/// Proxy vs Decorator
/// - Proxy provides an identical interface; decorator proveds an enhanced interface
/// - Decotrator typically aggregates (or has reference to) what it is decorating; proxy doesn't have to
/// - Proxy might not even be working with a materialized object. (A materialized object is an actual, fully instantiated object in memory. )
//
//import Foundation
//
//protocol Vehicle {
//  func drive()
//}
//
//class Car: Vehicle {
//  func drive() {
//    print("Car being driven")
//  }
//}
//
//class CarProxy: Vehicle {
//  private let car = Car()
//  private let driver: Driver
//
//  init(driver: Driver) {
//    self.driver = driver
//  }
//
//  func drive() {
//    if driver.age >= 16 {
//      car.drive()
//    } else {
//      print("Driver too young")
//    }
//  }
//}
//
//class Driver {
//  var age: Int
//  init(age: Int) {
//    self.age = age
//  }
//}
//
//func main() {
//  let car: Vehicle = CarProxy(driver: Driver(age: 12))
//  car.drive()
//}
//
//main()
