///// Overview: Avoid redundancy when storing data
///// E.g. MMORPG
///// - Plenty of users with identical first/last names
///// - No sense in storing same first/last name over and over again
///// - Store a list of names and pointers to them
///// String interning would not help
///// E.g., bold or italic text in the console
///// - Don't want each character to have a formatting character
///// - Operate on ranges (e.g., line number, start/end positions)
/////
///// Flyweight: A space optimization technique that lets us use less memory by storing externally the data associated with similar objects.
/////
//
//import Foundation
//
//class User {
//  var fullname: String
//
//  init(_ fullname: String) {
//    self.fullname = fullname
//  }
//
//  var charCount: Int {
//    return fullname.utf8.count
//  }
//}
//
///// more efficient user class
//class User2 {
//  static var strings = [String]()
//  private var names = [Int]()
//
//  init(_ fullName: String) {
//    func getOrAdd(_ s: String) -> Int {
//      if let idx = type(of: self).strings.firstIndex(of: s) {
//        return idx
//      } else {
//        type(of: self).strings.append(s)
//        return type(of: self).strings.count - 1
//      }
//    }
//    names = fullName.components(separatedBy: " ").map { getOrAdd($0) }
//  }
//
//  static var charCount: Int {
//    return strings.map { $0.utf8.count }.reduce(0, +)
//  }
//}
//
//func main() {
//  /// dupilicated "Smith", we can reduce the memory used here
//  let user1 = User("John Smith")
//  let user2 = User("Jane Smith")
//  let user3 = User("Jane Doe")
//  let totalChars = user1.charCount + user2.charCount + user3.charCount
//
//  print("Total number of chars used: \(totalChars)")  // Total number of chars used: 28
//
//  let user4 = User2("John Smith")
//  let user5 = User2("Jane Smith")
//  let user6 = User2("Jane Doe")
//
//  print("Total number of chars used: \(User2.charCount)")  // Total number of chars used: 16
//}
//
//main()
