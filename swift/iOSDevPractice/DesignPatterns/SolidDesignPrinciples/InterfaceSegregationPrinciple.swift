//import Foundation
//
//
///// Situation: You've got a document that is actually printed on paper.
///// Suppose you want to describe some sort of machine which actually operated on this document.
///// e.g., print the document, fax the document, scan the document.
///// How would you do this?
//
//class Document {
//
//}
//
///// You can create a protocol for documents but you can't make a machine like it has only a print function as it is pretty old machine.
//protocol Machine {
//  func print(_ d: Document)
//  func scan(_ d: Document)
//  func fax(_ d: Document)
//}
//
//class MultiFunctionPrinter: Machine {
//  func print(_ d: Document) {
//    // OK
//  }
//
//  func scan(_ d: Document) {
//    // OK
//  }
//
//  func fax(_ d: Document) {
//    // OK
//  }
//}
//
//class OldFashionedPrinter: Machine {
//  func print(_ d: Document) {
//    // OK
//  }
//
//  /// we do need to define this, but we can't.
//  /// How do we fix this?
//  func scan(_ d: Document) {
//    // NG
//  }
//
//  func fax(_ d: Document) {
//    // NG
//  }
//}
//
///// In interface segregation protocol, you split it up into sevetal protocols.
///// The goal of the interface segregation principle is that you don't put too much into a single protocol
///// because then you are forcing all the clients to implement additional functionality they might not even need.
///// So it's better to break up or segregate the protocol into the separate protocols, such as, for example,
///// the printer protocol, the scan protocol and so on, and then have the clients actually implement those separately.
///// And if they want, they can combine these protocols both in terms of their class declaration or if you
///// want, you can combine several protocols into a single protocol and then have the clients implement that as well.
//protocol Printer {
//  func print(_ d: Document)
//}
//
//protocol Scanner {
//  func scan(_ d: Document)
//}
//
//protocol Fax {
//  func fax(d: Document)
//}
//
//class OrdinaryPrinter: Printer {
//  func print(_ d: Document) {
//    // OK
//  }
//}
//
//class PhotoCopier: Printer, Scanner {
//  func print(_ d: Document) {
//    // OK
//  }
//
//  func scan(_ d: Document) {
//    // OK
//  }
//}
//
//protocol MultiFunctionDevice: Printer, Scanner, Fax {
//}
//
//class MultiFunctionMachine: MultiFunctionDevice {
//  let printer: Printer
//  let scanner: Scanner
//
//  init(printer: Printer, scanner: Scanner) {
//    self.printer = printer
//    self.scanner = scanner
//  }
//
//  func print(_ d: Document) {
//    printer.print(d) // Decorater
//  }
//
//  func scan(_ d: Document) {
//    // OK
//  }
//
//  func fax(d: Document) {
//    //OK
//  }
//}
