/// Motivation:
/// Consider an ordinary telephone
/// What you do with it depends on the state of the phone/line
/// - If it's ringing ot you want to make a call, you can pick it up
/// - Phone must be off the hook to talk/make a call
/// - If you try calling someone, and it's busy, you put the handset down
/// Changes in state can be explicit or in response to event (Observer pattern)
///
/// State: A pattern in which the object's behavior is determined by its state. An object transitions from one to state to another (something needs to trigger a transition).
/// A formalized construct which manages state and transitions is called a state machine.
//
//import Foundation
//
//enum State {
//  case offHook
//  case connecting
//  case connected
//  case onHold
//}
//
//enum Trigger {
//  case callDialed
//  case hungUp
//  case callConnected
//  case placedOnHold
//  case takenOffHold
//  case leftMessage
//}
//
//let rules = [
//  State.offHook: [
//    (Trigger.callDialed, State.connecting)
//  ],
//  State.connecting: [
//    (Trigger.hungUp, State.offHook),
//    (Trigger.callConnected, State.connected),
//  ],
//  State.connected: [
//    (Trigger.leftMessage, State.offHook),
//    (Trigger.hungUp, State.offHook),
//    (Trigger.placedOnHold, State.onHold),
//  ],
//  State.onHold: [
//    (Trigger.takenOffHold, State.connected),
//    (Trigger.hungUp, State.offHook),
//  ],
//]
//
//func main() {
//  var state = State.offHook
//
//  while true {
//    print("The phone is currently \(state)")
//    print("Select a trigger:")
//
//    for i in 0..<rules[state]!.count {
//      let (t, _) = rules[state]![i]
//      print("\(i). \(t)")
//    }
//
//    if let input = Int(readLine()!) {
//      let (_, s) = rules[state]![input]
//      state = s
//    }
//  }
//}
//
//main()

// The phone is currently offHook
// Select a trigger:
// 0. callDialed
// 0
// The phone is currently connecting
// Select a trigger:
// 0. hungUp
// 1. callConnected
// 1
// The phone is currently connected
// Select a trigger:
// 0. leftMessage
// 1. hungUp
// 2. placedOnHold
// 2
// The phone is currently onHold
// Select a trigger:
// 0. takenOffHold
// 1. hungUp
// 1
// The phone is currently offHook
// Select a trigger:
// 0. callDialed
// 0
