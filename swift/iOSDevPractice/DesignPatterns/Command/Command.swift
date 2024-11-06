///// Motivation:
///// Ordinary statements are perishable
///// - Cannot undo a property assignment
///// - Cannot directly serialize a sequence of actions (calls)
///// Want an object that represents an operation
///// - X should change its property y to z
///// - X should do w()
///// Uses: GUI commands, multi-level undo/redo, macro recording and more.
/////
///// Command: An object which represents an instruction to perform a particular action.
///// Contatins all the information necessary for the action to be taken.
/////
//
//import Foundation
//
//class BankAccount: CustomStringConvertible {
//  private var balance: Int = 0
//  private let overDraftLimit: Int = -500
//
//  func deposit(_ amount: Int) {
//    balance += amount
//    print("Deposited \(amount), balance = \(balance)")
//  }
//
//  func withdraw(_ amount: Int) -> Bool {
//    if balance - amount >= overDraftLimit {
//      balance -= amount
//      print("Withdrew \(amount), balance is now \(balance)")
//      return true
//    } else {
//      return false
//    }
//  }
//
//  var description: String {
//    return "Balance is \(balance)"
//  }
//}
//
//protocol Command {
//  func call()
//  func undo()
//}
//
//class BankAccountCommand: Command {
//
//  enum Action {
//    case deposit
//    case withdraw
//  }
//
//  private var account: BankAccount
//  private var action: Action
//  private var amount: Int
//  private var succeeded = false
//
//  init(_ account: BankAccount, _ action: Action, _ amount: Int) {
//    self.account = account
//    self.action = action
//    self.amount = amount
//  }
//
//  func call() {
//    switch action {
//    case .deposit:
//      account.deposit(amount)
//      succeeded = true
//    case .withdraw:
//      succeeded = account.withdraw(amount)
//    }
//  }
//
//  func undo() {
//    guard succeeded == true else { return }
//
//    switch action {
//    case .deposit:
//      account.withdraw(amount)
//    case .withdraw:
//      account.deposit(amount)
//    }
//  }
//}
//
//func main() {
//  let ba = BankAccount()
//
//  let commands = [
//    BankAccountCommand(ba, .deposit, 100),
//    BankAccountCommand(ba, .withdraw, 25),
//  ]
//
//  print(ba)  // Balance is 0
//
//  commands.forEach { $0.call() }
//  // Deposited 100, balance = 100
//  // Withdrew 25, balance is now 75
//
//  print(ba)  // Balance is 75
//
//  commands.reversed().forEach { $0.undo() }
//  // Deposited 25, balance = 100
//  // Withdrew 100, balance is now 0
//
//  print(ba)  // Balance is 0
//}
//
//main()
