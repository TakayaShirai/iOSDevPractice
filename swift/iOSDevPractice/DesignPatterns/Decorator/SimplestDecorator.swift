///// Motivation:
///// Want to augment an object with additional functionality
///// Do not want to rewrite or alter existing code (OCP)
///// Want to keep new functionality seperate (SRP)
///// Need to be ablr to interact with existing structures
/////
///// Two options:
///// Inherit from required object if possible; some objects are final -> x
///// Build a Decorator, which simply references the decorated object(s)
/////
///// Decorator: Facilitates the addition of behaviors to individual objects without inheriting from them.
//
//import Foundation
//
//class CodeBuilder: CustomStringConvertible {
//  /// This is the simplest decorator that you can build. this essentially decorates just a single object, String.
//  /// The reason we're decorating it is because we cannot inherit it and we end up constructing out buffer internally.
//  /// Replecating soe of the API of the original string, like append().
//  /// Adding our own functionality as well, appendLine().
//  private var buffer: String = ""
//
//  init() {}
//
//  init(_ buffer: String) {
//    self.buffer = buffer
//  }
//
//  func append(_ s: String) -> CodeBuilder {
//    buffer.append(s)
//    return self
//  }
//
//  func appendLine(_ s: String) -> CodeBuilder {
//    buffer.append("\(s)\n")
//    return self
//  }
//
//  static func += (cb: inout CodeBuilder, s: String) {
//    cb.buffer.append(s)
//  }
//
//  var description: String {
//    return buffer
//  }
//}
//func main() {
//  var cb = CodeBuilder()
//  cb.appendLine("class Foo")
//    .appendLine("{")
//
//  cb += "  // testing!\n"
//
//  cb.appendLine("}")
//  print(cb)
////  class Foo
////  {
////    // testing!
////  }
//}
//
////main()
