///// Motivation: An object or system goes through changes
///// - E.g., a bank account gets deposits and withdrawals
///// There are different ways of navigating those changes
///// One way is to record every change (Command) and teach a command to 'undo' itself.
///// Another is to simply save snapshots of the system (Memento).
/////
///// Memento: A token/handle representing the system state. Lets us roll back to the state when the token was generated.
///// May of may not directly expose state information.
/////
//
//import Foundation
//
//class Memento {
//  let balance: Int
//
//  init(_ balance: Int) {
//    self.balance = balance
//  }
//}
//
//class BankAccount: CustomStringConvertible {
//  private var balance: Int
//  private var changes = [Memento]()
//  private var current = 0
//
//  init(_ balance: Int) {
//    self.balance = balance
//    changes.append(Memento(balance))
//  }
//
//  func deposit(_ amount: Int) -> Memento {
//    balance += amount
//    let m = Memento(balance)
//    changes.append(m)
//    current += 1
//    return m
//  }
//
//  func restore(_ m: Memento?) {
//    guard let m = m else { return }
//
//    balance = m.balance
//    changes.append(m)
//    current = changes.count - 1
//  }
//
//  func undo() -> Memento? {
//    guard current > 0 else { return nil }
//
//    current -= 1
//    let m = changes[current]
//    balance = m.balance
//    return m
//  }
//
//  func redo() -> Memento? {
//    guard current + 1 < changes.count else { return nil }
//
//    current += 1
//    let m = changes[current]
//    balance = m.balance
//    return m
//  }
//
//  var description: String {
//    return "Balance = \(balance)"
//  }
//}
//
//func main() {
//  let ba = BankAccount(100)
//  let m1 = ba.deposit(50)
//  let m2 = ba.deposit(20)
//  print(ba)  // Balance = 170
//
//  ba.undo()
//  print("Undo 1: \(ba)")  // Undo 1: Balance = 150
//
//  ba.undo()
//  print("Undo 2: \(ba)")  // Undo 2: Balance = 100
//
//  ba.redo()
//  print("Redo 1: \(ba)")  // Redo 1: Balance = 150
//}
//
//main()
