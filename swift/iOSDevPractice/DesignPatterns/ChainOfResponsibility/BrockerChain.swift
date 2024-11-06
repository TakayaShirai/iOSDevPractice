//import Foundation
//
//// Protocol defining an invocable action, used for event handling.
//protocol Invocable: AnyObject {
//  func invoke(_ data: Any)
//}
//
//// Protocol for managing disposable resources, often used to stop event handling.
//public protocol Disposable {
//  func dispose()
//}
//
//// Event class that uses the observer pattern to notify handlers when an event is raised.
//public class Event<T> {
//  public typealias EventHandler = (T) -> Void
//
//  // Collection of event handlers that will be notified when the event is raised.
//  var eventHandlers = [Invocable]()
//
//  // Method to trigger the event, invoking all handlers with provided data.
//  public func raise(_ data: T) {
//    for handler in self.eventHandlers {
//      handler.invoke(data)
//    }
//  }
//
//  // Method to add an event handler to this event. Returns a Disposable to allow removing the handler.
//  public func addHandler<U: AnyObject>(target: U, handler: @escaping (U) -> EventHandler)
//    -> Disposable
//  {
//    // Creates a subscription linking the target and handler, and adds it to the list of handlers.
//    let subscription = Subscription(target: target, handler: handler, event: self)
//    eventHandlers.append(subscription)
//    return subscription
//  }
//}
//
//// Subscription class represents a single event subscription, tying together a target and handler.
//class Subscription<T: AnyObject, U>: Invocable, Disposable {
//  weak var target: T?  // Weak reference to the target to avoid retain cycles.
//  let handler: (T) -> (U) -> Void  // Closure for handling the event.
//  let event: Event<U>  // Reference to the event to allow handler removal.
//
//  init(target: T?, handler: @escaping (T) -> (U) -> Void, event: Event<U>) {
//    self.target = target
//    self.handler = handler
//    self.event = event
//  }
//
//  // Method to invoke the handler if the target still exists.
//  func invoke(_ data: Any) {
//    if let t = target {
//      handler(t)(data as! U)
//    }
//  }
//
//  // Method to remove this subscription from the event's handlers list.
//  func dispose() {
//    event.eventHandlers = event.eventHandlers.filter { $0 as AnyObject? !== self }
//  }
//}
//
//// Class representing a Query to access data without modifying state (CQS principle).
//class Query {
//  var creatureName: String
//  enum Argument {
//    case attack
//    case defense
//  }
//  var whatToQuery: Argument  // Type of query (attack or defense).
//  var value: Int  // The value affected by the query.
//
//  init(name: String, whatToQuery: Argument, value: Int) {
//    self.creatureName = name
//    self.whatToQuery = whatToQuery
//    self.value = value
//  }
//}
//
//// Mediator class to manage interactions between creatures and modifiers using events.
//class Game {
//  let queries = Event<Query>()  // Event to raise queries on creatures' attributes.
//
//  // Method to perform a query by raising it as an event.
//  func performQuery(sender: AnyObject?, q: Query) {
//    queries.raise(q)
//  }
//}
//
//// Creature class with properties for name, attack, and defense.
//class Creature: CustomStringConvertible {
//  var name: String
//  private let _attack: Int  // Base attack
//  private let _defense: Int  // Base defense
//  private let game: Game  // Reference to the game mediator
//
//  init(game: Game, name: String, attack: Int, defense: Int) {
//    self.game = game
//    self.name = name
//    _attack = attack
//    _defense = defense
//  }
//
//  // Computed property for attack that raises a query to allow modifiers to adjust the value.
//  var attack: Int {
//    let q = Query(name: name, whatToQuery: Query.Argument.attack, value: _attack)
//    game.performQuery(sender: self, q: q)
//    return q.value
//  }
//
//  // Computed property for defense that raises a query similarly.
//  var defense: Int {
//    let q = Query(name: name, whatToQuery: Query.Argument.defense, value: _defense)
//    game.performQuery(sender: self, q: q)
//    return q.value
//  }
//
//  // Description for displaying creature properties.
//  var description: String {
//    return "Name: \(name), A = \(attack), D = \(defense)"
//  }
//}
//
//// Base class for creature modifiers. Modifiers attach to creatures and modify their attributes.
//class CreatureModifier: Disposable {
//  let game: Game
//  let creature: Creature
//  var event: Disposable? = nil  // Subscription to the event for cleanup.
//
//  init(_ game: Game, _ creature: Creature) {
//    self.game = game
//    self.creature = creature
//    event = self.game.queries.addHandler(target: self, handler: CreatureModifier.handle)
//  }
//
//  // Handler for query events. To be implemented by subclasses.
//  func handle(q: Query) {
//    // Subclasses implement specific behavior here.
//  }
//
//  // Unsubscribes this modifier from the event when it's no longer needed.
//  func dispose() {
//    event?.dispose()
//  }
//}
//
//// Modifier that doubles a creature's attack.
//class DoubleAttackModifier: CreatureModifier {
//  override func handle(q: Query) {
//    // Check if the query is for this creature's attack and doubles the value.
//    if q.creatureName == creature.name && q.whatToQuery == Query.Argument.attack {
//      q.value *= 2
//    }
//  }
//}
//
//// Modifier that increases a creature's defense by 2.
//class IncreaseDefenseModifier: CreatureModifier {
//  override func handle(q: Query) {
//    // Check if the query is for this creature's defense and increases the value by 2.
//    if q.creatureName == creature.name && q.whatToQuery == Query.Argument.defense {
//      q.value += 2
//    }
//  }
//}
//
//// How It Works
///// When you instantiate a modifier, such as DoubleAttackModifier, for a Creature, it automatically subscribes to the Game’s queries event.
///// Here’s what happens step-by-step:
///// Modifier Subscribes to Event: When DoubleAttackModifier(game, goblin) is created,
///// it calls addHandler to subscribe to game.queries with a handler method (handle) that can modify the query’s value.
///// Raising the Query: When you access goblin.attack or goblin.defense, the Creature class raises a Query event by calling game.performQuery.
///// Modifier Handling: The Game object then notifies all subscribers (like DoubleAttackModifier) of this Query. If the modifier’s criteria match the query (e.g., it’s for the attack of the specific Creature named "Strong Goblin"), it modifies the value in the query. This modified value is then returned as the attribute value.
//
//// Why Modifiers Apply Automatically
///// The modifiers work without direct calls because:
///// Dynamic Query Resolution: Creature does not store the modified attack or defense values; instead,
///// it raises a query each time. Any active modifier that subscribes to these queries can modify the attributes on-the-fly.
///// Observer Pattern: By using the observer pattern, Creature and its modifiers are loosely coupled.
///// The Creature class is not aware of specific modifiers, allowing flexibility for adding or removing modifiers dynamically.
//
//
//func main() {
//  let game = Game()
//  let goblin = Creature(
//    game: game, name: "Strong Goblin",
//    attack: 3, defense: 3)
//  print("Baseline goblin: \(goblin)")  // Baseline goblin: Name: Strong Goblin, A = 3, D = 3
//
//  // Applying a double attack modifier.
//  let dam = DoubleAttackModifier(game, goblin)
//  print("Goblin with double attack: \(goblin)")  // Goblin with double attack: Name: Strong Goblin, A = 6, D = 3
//
//  // Applying an increase defense modifier.
//  let idm = IncreaseDefenseModifier(game, goblin)
//  print("Goblin with 2x attack and inc def: \(goblin)")  // Goblin with 2x attack and inc def: Name: Strong Goblin, A = 6, D = 5
//
//  // Removing the double attack modifier.
//  dam.dispose()
//  print("Goblin is now \(goblin)")  // Goblin is now Name: Strong Goblin, A = 3, D = 5
//
//  // Removing the increase defense modifier.
//  idm.dispose()
//  print("Goblin is now \(goblin)")  // Goblin is now Name: Strong Goblin, A = 3, D = 3
//}
//
//main()
