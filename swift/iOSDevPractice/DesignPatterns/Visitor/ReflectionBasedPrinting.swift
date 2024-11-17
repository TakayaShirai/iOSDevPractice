//import Foundation
//
//protocol Expression {}
//
//class DoubleExpression: Expression {
//  public var value: Double
//
//  init(_ value: Double) {
//    self.value = value
//  }
//}
//
//class AdditionExpression: Expression {
//  public var left: Expression
//  public var right: Expression
//
//  init(_ left: Expression, _ right: Expression) {
//    self.left = left
//    self.right = right
//  }
//}
//
//class ExpressionPrinter {
//  func print(_ e: Expression, _ s: inout String) {
//    if let de = e as? DoubleExpression {
//      s.append(String(de.value))
//    } else if let ae = e as? AdditionExpression {
//      s.append("(")
//      print(ae.left, &s)
//      s.append("+")
//      print(ae.right, &s)
//      s.append(")")
//    }
//  }
//
//}
//
//func main() {
//  let e = AdditionExpression(
//    DoubleExpression(1),
//    AdditionExpression(
//      DoubleExpression(2),
//      DoubleExpression(3)
//    )
//  )
//
//  var s = ""
//  let ep = ExpressionPrinter()
//  ep.print(e, &s)
//  print(s)  // (1.0+(2.0+3.0))
//}
//
//main()
