///// Motivation: Many algorithms can be decomposed into higher- and lower- level parts.
///// Making tea can be decomposed into
///// - The process of making a hot beverage (boil water, pour into cup); and
///// - Tea-specific things (put teabag into water)
///// The high-level algorithm can then be reused for making coffee or hot chocolate
///// - Supported by beverage-specific strategies
/////
///// Strategy: Enables the exact behavior of a system to be selected either at run-time (dynamic) or compile-time (static).
///// Also known as policy (esp. in the C++ world).
//
//import Foundation
//
//enum OutputFormat {
//  case markdown
//  // * one
//  // * two
//  case html
//  // <ul>
//  //   <li>one</li>
//  // </ul>
//}
//
//protocol ListStrategy {
//  init()
//  func start(_ buffer: inout String)
//  func end(_ buffer: inout String)
//  func addListItem(buffer: inout String, item: String)
//}
//
//class MarkdownListStrategy: ListStrategy {
//  required init() {}
//  func start(_ buffer: inout String) {}
//  func end(_ buffer: inout String) {}
//  func addListItem(buffer: inout String, item: String) {
//    buffer.append(" * \(item)\n")
//  }
//}
//
//class HtmlListStrategy: ListStrategy {
//  required init() {}
//
//  func start(_ buffer: inout String) {
//    buffer.append("<ul>\n")
//  }
//
//  func end(_ buffer: inout String) {
//    buffer.append("</ul>\n")
//  }
//  func addListItem(buffer: inout String, item: String) {
//    buffer.append("  <li>\(item)</li>\n")
//  }
//}
//
//// Dynamic Strategy
////class TextProcessor: CustomStringConvertible {
////  private var buffer = ""
////  private var listStrategy: ListStrategy
////
////  init(_ outputFormat: OutputFormat) {
////    switch outputFormat {
////      case .markdown:
////        listStrategy = MarkdownListStrategy()
////      case .html:
////        listStrategy = HtmlListStrategy()
////    }
////  }
////
////  func setOutputFormat(_ outputFormat: OutputFormat) {
////    switch outputFormat {
////      case .markdown:
////        listStrategy = MarkdownListStrategy()
////      case .html:
////        listStrategy = HtmlListStrategy()
////    }
////  }
////
////  func appendList(_ items: [String]) {
////    listStrategy.start(&buffer)
////    for item in items {
////      listStrategy.addListItem(buffer: &buffer, item: item)
////    }
////    listStrategy.end(&buffer)
////  }
////
////  func clear() {
////    buffer = ""
////  }
////
////  var description: String {
////    return buffer
////  }
////}
//
//// Static Strategy
//class TextProcessor<LS>: CustomStringConvertible where LS: ListStrategy {
//  private var buffer = ""
//  private let listStrategy = LS()
//
//  func appendList(_ items: [String]) {
//    listStrategy.start(&buffer)
//    for item in items {
//      listStrategy.addListItem(buffer: &buffer, item: item)
//    }
//    listStrategy.end(&buffer)
//  }
//
//  func clear() {
//    buffer = ""
//  }
//
//  var description: String {
//    return buffer
//  }
//}
//
//func main() {
//  // Static Strategy
//  let tp = TextProcessor<MarkdownListStrategy>()
//  tp.appendList(["foo", "bar", "baz"])
//  print(tp)
//  // * foo
//  // * bar
//  // * baz
//
//  let tp2 = TextProcessor<HtmlListStrategy>()
//  tp2.appendList(["foo", "bar", "baz"])
//  print(tp2)
//  // <ul>
//  //   <li>foo</li>
//  //   <li>bar</li>
//  //   <li>baz</li>
//  // </ul>
//
//  // Dynamic Strategy
//  //  let tp = TextProcessor(.markdown)
//  //  tp.appendList(["foo", "bar", "baz"])
//  //  print(tp)
//  //  // * foo
//  //  // * bar
//  //  // * baz
//  //
//  //  tp.clear()
//  //  tp.setOutputFormat(.html)
//  //  tp.appendList(["foo", "bar", "baz"])
//  //  print(tp)
//  //  // <ul>
//  //  //   <li>foo</li>
//  //  //   <li>bar</li>
//  //  //   <li>baz</li>
//  //  // </ul>
//}
//
//main()
