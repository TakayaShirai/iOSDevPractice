///// Motivation:
///// Unethical behavior by an employee; who takes the blame?
///// - Employee
///// - Manager
///// - CEO
///// You click a graphical element on a form
///// - Button handles it, stops further processing
///// - Underlying group box
///// - Underlying window
///// CCG computer game
///// - Creature has attack and defence values
///// - Those can be boosted by other cards
/////
///// Chain of Responsibility:
///// A chain of components who all get a chance to process a command or a query,
///// optionally having default processing implementation and an ability to terminate the processing chain.
/////
///// Command Query Separation:
///// Command = asking for an action or change (e.g., please set your attack value to 2).
///// Query = asking for information (e.g., please give me your attack value).
///// CQS = having separate means of sending commands and queries to e.g., direct field access.
/////
///// Benefits of CQS
///// - Improves readability and predictability: By enforcing clear distinctions, developers can more easily understand a method’s purpose
///// without having to check if it’s changing state.
///// - Simplifies debugging: Since queries don’t change state, debugging state changes becomes more straightforward.
///// - Encourages a cleaner API: Separating commands from queries leads to cleaner, more modular code, which can improve maintenance and testing.
/////
//
//import Foundation
//
//class Creature: CustomStringConvertible {
//  var name: String
//  var attack: Int
//  var defense: Int
//
//  init(_ name: String, _ attack: Int, _ defense: Int) {
//    self.name = name
//    self.attack = attack
//    self.defense = defense
//  }
//
//  var description: String {
//    return "Name: \(name), A = \(attack), D = \(defense)"
//  }
//}
//
//class CreatureModifier {
//  let creature: Creature
//  var next: CreatureModifier?
//
//  init(_ creature: Creature) {
//    self.creature = creature
//  }
//
//  func add(_ cm: CreatureModifier) {
//    if let next = next {
//      next.add(cm)
//    } else {
//      next = cm
//    }
//  }
//
//  func handle() {
//    next?.handle()
//  }
//}
//
//class DoubleAttackModifier: CreatureModifier {
//  override func handle() {
//    print("Doubling \(creature.name)'s attack")
//    creature.attack *= 2
//    super.handle()
//  }
//}
//
//class IncreaseDefenseModifier: CreatureModifier {
//  override func handle() {
//    print("Increasing \(creature.name)'s defense")
//    creature.defense += 3
//    super.handle()
//  }
//}
//
//class NoBunusesModifier: CreatureModifier {
//  override func handle() {
//
//  }
//}
//
//func main() {
//  let goblin = Creature("Goblin", 2, 2)
//  print(goblin) // Name: Goblin, A = 2, D = 2
//
//  let root = CreatureModifier(goblin)
//
//  /// When we add this "NoBobusesModifier", goblin can get any modification.
////  root.add(NoBunusesModifier(goblin))
//
//
//  print("Let's double the goblin's attack")
//  root.add(DoubleAttackModifier(goblin))
//
//  print("Let's increase the goblin's attack")
//  root.add(IncreaseDefenseModifier(goblin))
//
//  root.handle()
//  // Doubling Goblin's attack
//  // Increasing Goblin's defense
//
//  print(goblin) // Name: Goblin, A = 4, D = 5
//}
//
//main()
