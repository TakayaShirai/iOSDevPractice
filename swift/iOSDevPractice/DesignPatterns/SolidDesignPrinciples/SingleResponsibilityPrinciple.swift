//// Single Responsibility Principle
///// A class should have a single responsibility, a single reason to change.
///// Single Responsibility Principle basically states that if you have something like persistence, you have to move it to a seperate class.
//
//import Foundation
//
//class Journal: CustomStringConvertible {
//  var entries = [String]()
//  var count = 0
//
//  func addEntry(_ text: String) -> Int {
//    count += 1
//    entries.append("\(count): \(text)")
//    return count - 1
//  }
//
//  func removeRntry(_ index: Int) {
//    entries.remove(at: index)
//  }
//
//  var description: String {
//    return entries.joined(separator: "\n")
//  }
//}
//
///// the class where you would put all the functionality related to actually saving the journal.
///// imagine that in addition to a journal class, you also have a diary class which also needs persistence.
///// you can put save or load functionalities into a single class, thereby adhering to the single responsibility principle.
///// If not, you have to write a save and load function within each journal and diary class.
//class Persistence {
//  func loadfile(filename: String) {}
//  func saveJournal(journal: Journal, filename: String, overwrite: Bool = false) {}
//}
//
//func SRPMain() {
//  let j = Journal()
//  let _ = j.addEntry("I cried today")
//  let bug = j.addEntry("I ate a bug")
//  print(j)
//
//  j.removeRntry(bug)
//  print("===")
//  print(j)
//
//  let p = Persistence()
//  let filename = "filename"
//  p.saveJournal(journal: j, filename: filename)
//}
//
////SRPMain()
