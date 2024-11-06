///// The Property class in this code acts as a "property proxy," which is an intermediary that wraps another value to provide additional functionality.
///// This technique is often used to control access to properties, add logging, perform validation, notify changes,
///// or implement other side effects whenever a property’s value is accessed or modified
//
///// Benefits of Using a Property Proxy
///// Controlled Access: Ensures additional checks, conditions, or side effects are consistently applied whenever the property changes.
///// Reusability: The Property proxy is reusable across any class or struct, providing the same functionality for any Equatable type.
///// Separation of Concerns: Keeps the logging or side effect code separate from the primary class (like Creature), making the primary class cleaner and focused on its main purpose.
/////
//
//import Foundation
//
//class Property<T: Equatable> {
//
//  private var _value: T
//
//  public var value: T {
//    get { return _value }
//    set {
//      if newValue == _value { return }
//      print("Setting value to \(newValue)")
//      _value = newValue
//    }
//  }
//
//  init(_ value: T) {
//    self._value = value
//  }
//}
//
//extension Property: Equatable {}
//
//func == <T>(lhs: Property<T>, rhs: Property<T>) -> Bool {
//  return lhs.value == rhs.value
//}
//
//class Creature {
//  private let _agility = Property<Int>(0)
//
//  var agility: Int {
//    get { return _agility.value }
//    set(value) { _agility.value = value }
//  }
//}
//
//func main() {
//  let c = Creature()
//  c.agility = 10  // Setting value to 10
//
//  print(c.agility)  // 10
//}
//
//main()
