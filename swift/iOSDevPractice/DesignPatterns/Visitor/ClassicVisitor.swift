///// Motivation: Need to define a new operation on an entire class hierarchy
///// - Eg.g, make a document model printable to HTML/Markdown
///// Do not want to keep modifying every class in the hierarchy
///// Need access to the non-common aspects of classes in the hierarchy
///// - I.e., an extension method won't do
///// Create an external component to handle rendering
///// - But avoid type checks
/////
///// Visitor: A pattern where a component (visitor) is allowed to traverse the entire inheritance hierarchy.
///// Implemented by propagating a single visit() method throughout the entire hierarchy.
/////
///// Dispatch:
///// - Which function to call?
///// - Single dispatch: depends on name of request and type of receiver
///// - Double dispatch: depends on name of request and type of two receivers (type of visiotr, type of element being visited)
//
//import Foundation
//
//protocol Expression {
//  func accept(_ visitor: ExpressionVisitor)
//}
//
//class DoubleExpression: Expression {
//  public var value: Double
//
//  init(_ value: Double) {
//    self.value = value
//  }
//
//  func accept(_ visitor: ExpressionVisitor) {
//    visitor.visit(self)
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
//
//  func accept(_ visitor: ExpressionVisitor) {
//    visitor.visit(self)
//  }
//}
//
//protocol ExpressionVisitor {
//  func visit(_ de: DoubleExpression)
//  func visit(_ ae: AdditionExpression)
//}
//
//class ExpressionPrinter: ExpressionVisitor, CustomStringConvertible {
//  private var buffer = ""
//
//  func visit(_ de: DoubleExpression) {
//    buffer.append(String(de.value))
//  }
//
//  func visit(_ ae: AdditionExpression) {
//    buffer.append("(")
//    ae.left.accept(self)
//    buffer.append("+")
//    ae.right.accept(self)
//    buffer.append(")")
//  }
//
//  var description: String {
//    return buffer
//  }
//}
//
//class ExpressionCalculator: ExpressionVisitor {
//  public var result: Double = 0
//
//  func visit(_ de: DoubleExpression) {
//    result = de.value
//  }
//
//  func visit(_ ae: AdditionExpression) {
//    ae.left.accept(self)
//    let leftVal = result
//    ae.right.accept(self)
//    let rightVal = result
//    result = leftVal + rightVal
//  }
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
//  let ep = ExpressionPrinter()
//  ep.visit(e)
//  print(ep)  // (1.0+(2.0+3.0))
//
//  let calc = ExpressionCalculator()
//  calc.visit(e)
//  print("\(ep) = \(calc.result)")  // (1.0+(2.0+3.0)) = 6.0
//}
//
//main()
