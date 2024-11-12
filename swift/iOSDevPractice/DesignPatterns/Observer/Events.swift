///// Motivation: We need to be informed when certain things happen
///// - Object's property changes
///// - Object does something
///// - Some external event occurs
///// We want to listen to events and notified when they occur
///// Built into Swift for properties only
/////
///// Observer: An observer is an object that wishes to be informed about events happening in the system.
///// The entity generating the event is an observable.
//
//import Foundation
//
//protocol Invocable {
//  func invoke(_ data: Any)
//}
//
//protocol Disposable {
//  func dispose()
//}
//
//class Event<T> {
//  typealias EventHandler = (T) -> Void
//
//  var eventHandlers = [Invocable]()
//
//  // Method to trigger the event, passing data to all event handlers
//  func raise(_ data: T) {
//    for handler in eventHandlers {
//      handler.invoke(data)
//    }
//  }
//
//  // (U) -> (T) -> ()
//  // Method to add a handler to the event
//  // The handler takes an instance of type U (any class type)
//  // and returns a function that processes the event data of type T.
//  func addHandler<U: AnyObject>(target: U, handler: @escaping (U) -> EventHandler) -> Disposable {
//    let subscription = Subscription(target: target, handler: handler, event: self)
//    eventHandlers.append(subscription)
//    return subscription
//  }
//}
//
//class Subscription<T: AnyObject, U>: Invocable, Disposable {
//  // the target refers to the object that will be responsible for handling the event
//  // when it's raised. Specifically, it refers to the instance of a class that contains
//  // the method to be executed in response to the event.
//  weak var target: T?
//  let handler: (T) -> (U) -> Void
//  let event: Event<U>
//
//  init(target: T?, handler: @escaping (T) -> (U) -> Void, event: Event<U>) {
//    self.target = target
//    self.handler = handler
//    self.event = event
//  }
//
//  func invoke(_ data: Any) {
//    guard let target = target else { return }
//    handler(target)(data as! U)  // Invoke the handler with the correct data type (casted to U)
//  }
//
//  // Dispose of the subscription, removing it from the event's list of handlers
//  func dispose() {
//    event.eventHandlers = event.eventHandlers.filter { $0 as AnyObject !== self }
//  }
//}
//
//class Person {
//  // Event that will carry a String (the address where a doctor is needed)
//  let fallsIll = Event<String>()
//
//  init() {}
//
//  func catchCold() {
//    fallsIll.raise("8888 University Drive")
//  }
//}
//
//class Demo {
//  init() {
//    let p = Person()
//
//    // Subscribe to the fallsIll event. When the event is triggered, call the `callDoctor` method
//    let sub = p.fallsIll.addHandler(target: self, handler: Demo.callDoctor)
//
//    p.catchCold()  // We need a doctor at 8888 University Drive.
//
//    // Unsubscribe from the event by calling dispose
//    sub.dispose()
//
//    // no action will happen because we unsubscribed
//    p.catchCold()
//  }
//
//  // The method that will be called when the event is raised
//  func callDoctor(address: String) {
//    print("We need a doctor at \(address).")
//  }
//}
//
//func main() {
//  let _ = Demo()
//}
//
//main()
