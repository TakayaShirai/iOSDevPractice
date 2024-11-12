///// Motivation : When component A uses component B, it typically assumes that B is not nill
///// - You inject B, not B? or some Option<B>
///// - You do not check for nil (?.) in every call.
///// There is no option of telling A not to use an instance of B
///// - Its use is hard-coded
///// Thus, we build a no-op, non-functioning inheritor of B and pass it into A.
/////
///// Null Object: A no-op object that conforms to the required interface, satisfying a dependency requirement of some other object.
//
//import Foundation
//
//protocol Log {
//  func info(_ msg: String)
//  func warn(_ msg: String)
//}
//
//class ConsoleLog: Log {
//  func info(_ msg: String) {
//    print("INFO: \(msg)")
//  }
//
//  func warn(_ msg: String) {
//    print("WARN: \(msg)")
//  }
//}
//
///// you can use this and avoid using nil value for the variable "log" in the class "BankAccount"
//class NullLog: Log {
//  func info(_ msg: String) {}
//  func warn(_ msg: String) {}
//}
//
//class BankAccount {
//  var log: Log
//  var balance = 0
//
//  init(_ log: Log = ConsoleLog()) {
//    self.log = log
//  }
//
//  func deposit(_ amount: Int) {
//    balance += amount
//    log.info("Deposited \(amount), balance is now \(balance).")
//  }
//}
//
//func main() {
//  let log = ConsoleLog()
//  let nullLog = NullLog()
//
//  let ba1 = BankAccount(log)
//  let ba2 = BankAccount(nullLog)
//
//  ba1.deposit(100)  // INFO: Deposited 100, balance is now 100.
//  ba2.deposit(100)
//}
//
//main()
