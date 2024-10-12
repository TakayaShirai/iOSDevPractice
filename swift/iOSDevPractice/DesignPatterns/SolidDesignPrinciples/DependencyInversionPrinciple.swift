//import Foundation
//
///// Dependency Inversion Principle specifies two seperate things.
///// High-level modules are the parts of your code that handle important, big-picture tasks.
///// Low-level modules are the parts of your code that handle the details, like specific functions or classes that perform smaller tasks.
///// The principle says that the big-picture parts shouldn’t directly depend on the details of how smaller tasks are done.
///// Both high-level and low-level parts of your code should rely on something more general, called an abstraction.
///// An abstraction is like a general blueprint or interface, which doesn’t focus on the details of how something is done.
///// The general blueprints (abstractions) should not rely on specific implementations (details), but the specific parts of your code should follow those blueprints.
//
//enum Relationship {
//  case parent
//  case child
//  case sibling
//}
//
//class Person{
//  var name = ""
//
//  init(name: String = "") {
//    self.name = name
//  }
//}
//
///// The below example is bad because the high-level module depends on low-level module. (using Relationship in Research)
///// This violates the Dependency Inversion Principle.
//class Relationships { // low-level
//  var relations = [(Person, Relationship, Person)]()
//
//  func addParentAndChild(parent p: Person, child c: Person) {
//    relations.append((p, Relationship.parent, c))
//    relations.append((c, Relationship.child, p))
//  }
//}
//
//class Research { // high-level
//  init(_ relationships: Relationships) {
//    let relations = relationships.relations
//    for r in relations where r.0.name == "John" && r.1 == Relationship.parent {
//      print("John has a child called \(r.2.name)")
//    }
//  }
//}
//
//func main() {
//  let parent = Person(name: "John")
//  let child1 = Person(name: "Chris")
//  let child2 = Person(name: "Matt")
//
//  let relationships = Relationships()
//  relationships.addParentAndChild(parent: parent, child: child1)
//  relationships.addParentAndChild(parent: parent, child: child2)
//
//  let _ = Research(relationships)
//}
//
//protocol RelationshipsBrowser {
//  func findAllChildOf(name: String) -> [Person]
//}
//
//class modifiedRelationships: RelationshipsBrowser {
//  private var relations = [(Person, Relationship, Person)]()
//
//  func addParentAndChild(parent p: Person, child c: Person) {
//    relations.append((p, Relationship.parent, c))
//    relations.append((c, Relationship.child, p))
//  }
//
//  func findAllChildOf(name: String) -> [Person] {
//    return relations
//      .filter({
//        return $0.name == name && $1 == Relationship.parent && $2 === $2
//      })
//      .map{$2}
//  }
//}
//
///// And now the implementation of all of this stays pretty much the same. We still need relationships. We still need to initialize them somehow.
///// But the key difference here is that when you pass in relationships, you're not passing in as a concrete implementation.
///// Instead you're passing it as a protocol. So essentially instead of relationships, you could have some other proxy or
///// something else which conforms to the protocol of relationship browser. So this way, instead of the high level module,
///// depending on the low level module, the high levelmodule actually depends on an abstraction, and this abstraction is the relationship browser.
//
//class modifiedResearch {
//  init(_ browser: RelationshipsBrowser) {
//    for p in browser.findAllChildOf(name: "John") {
//      print("John has a child called \(p.name)")
//    }
//  }
//}
