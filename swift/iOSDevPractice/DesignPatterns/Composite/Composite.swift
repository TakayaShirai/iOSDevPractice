///// Composite: A mechanism for treating individual (scalar) objects and compositions of objects in a uniform manner.
///// This pattern is particularly useful when you have a tree-like structure of objects, where some objects contain other objects,
///// and you want to interact with all objects (whether simple or composite) using the same interface.
//
//import Foundation
//
//class GraphicOnject: CustomStringConvertible {
//  var name: String = "Group"
//  var color: String = ""
//
//  var children = [GraphicOnject]()
//
//  init() {}
//  init(name: String) { self.name = name }
//
//  private func print(_ buffer: inout String, _ depth: Int) {
//    buffer.append(String(repeating: "*", count: depth))
//    buffer.append(color.isEmpty ? "" : "\(color) ")
//    buffer.append("\(name)\n")
//
//    for child in children {
//      child.print(&buffer, depth+1)
//    }
//  }
//
//  var description: String {
//    var buffer = ""
//    print(&buffer, 0)
//    return buffer
//  }
//}
//
//class Square: GraphicOnject {
//  init(_ color: String) {
//    super.init(name: "Square")
//    self.color = color
//  }
//}
//
//class Circle: GraphicOnject {
//  init(_ color: String) {
//    super.init(name: "Circle")
//    self.color = color
//  }
//}
//
//func main() {
//  let drawing = GraphicOnject(name: "My Drawing")
//  drawing.children.append(Square("Red"))
//  drawing.children.append(Circle("Blue"))
//
//  let group = GraphicOnject()
//  group.children.append(Circle("Yellow"))
//  group.children.append(Square("Green"))
//
//  drawing.children.append(group)
//
//  print(drawing.description)
//  // My Drawing
//  // *RedSquare
//  // *BlueCircle
//  // *Group
//  // **YellowCircle
//  // **GreenSquare
//}
//
//main()
