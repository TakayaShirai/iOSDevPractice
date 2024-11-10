///// Motivation: Components may go in and out of a system at any time
///// - Chat room participants
///// - Players in an MMORPG
///// It makes no sense for them to have direct references to one another
///// - Those references may go dead
///// Solution: have them all refer to some central component that facilitates commnucation
/////
///// Mediator: A component that facilitates communication between other components
///// without them necessarily being aware of each other or having direct (reference) access to each other.
//
//import Foundation
//
//class Person {
//  var name: String
//  var room: ChatRoom? = nil
//  private var chatLog = [String]()
//
//  init(_ name: String) {
//    self.name = name
//  }
//
//  func receive(sender: String, message: String) {
//    let s = "\(sender): `\(message)`"
//    print("[\(name)'s chat session] \(s)")
//    chatLog.append(s)
//  }
//
//  func say(_ message: String) {
//    room?.broadcast(sender: name, message: message)
//  }
//
//  func pm(target: String, message: String) {
//    room?.message(sender: name, destination: target, message: message)
//  }
//}
//
//class ChatRoom {
//  private var people = [Person]()
//
//  func broadcast(sender: String, message: String) {
//    for p in people {
//      if p.name != sender {
//        p.receive(sender: sender, message: message)
//      }
//    }
//  }
//
//  func join(_ p: Person) {
//    let joinMsg = "\(p.name) has joined the chat room."
//    broadcast(sender: "room", message: joinMsg)
//    p.room = self
//    people.append(p)
//  }
//
//  func message(sender: String, destination: String, message: String) {
//    people.first { $0.name == destination }?.receive(sender: sender, message: message)
//  }
//}
//
//func main() {
//  let room = ChatRoom()
//
//  let john = Person("John")
//  let jane = Person("Jane")
//
//  room.join(john)
//  room.join(jane)  // [John's chat session] room: `Jane has joined the chat room.`
//
//  john.say("hi")  // [Jane's chat session] John: `hi`
//  jane.say("hello")  // [John's chat session] Jane: `hello`
//
//  let simon = Person("Simon")
//  room.join(simon)
//  // [John's chat session] room: `Simon has joined the chat room.`
//  // [Jane's chat session] room: `Simon has joined the chat room.`
//  simon.say("hi everyone")
//  // [John's chat session] Simon: `hi everyone`
//  // [Jane's chat session] Simon: `hi everyone`
//
//  jane.pm(target: "Simon", message: "glad you could join us")  // [Simon's chat session] Jane: `glad you could join us`
//}
//
//main()
