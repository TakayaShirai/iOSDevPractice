///// Adapter: A construct which adapts an existing interface X to conform to the required interface Y.
//
//import Foundation
//
//class Point: CustomStringConvertible, Hashable {
//  var x: Int
//  var y: Int
//
//  init(_ x: Int, _ y: Int) {
//    self.x = x
//    self.y = y
//  }
//
//  var description: String {
//    return "\(x), \(y)"
//  }
//
//  var hashValue: Int {
//    return (x * 397) ^ y
//  }
//
//  static func == (lhs: Point, rhs: Point) -> Bool {
//    return lhs.x == rhs.x && lhs.y == rhs.y
//  }
//}
//
//class Line: CustomStringConvertible, Hashable {
//  var description: String {
//    return "Line from \(start) to \(end)"
//  }
//
//  static func == (lhs: Line, rhs: Line) -> Bool {
//    return lhs.start == rhs.start && lhs.end == rhs.end
//  }
//
//  var start: Point
//  var end: Point
//
//  init(_ start: Point, _ end: Point) {
//    self.start = start
//    self.end = end
//  }
//
//  var hashValue: Int {
//    return (start.hashValue * 397) ^ end.hashValue
//  }
//}
//
//class VectorObject: Sequence {
//  var lines = [Line]()
//
//  func makeIterator() -> IndexingIterator<[Line]> {
//    return IndexingIterator(_elements: lines)
//  }
//}
//
//class VectorRectangle: VectorObject {
//
//  init(_ x: Int, _ y: Int, _ width: Int, _ height: Int) {
//    super.init()
//    lines.append(Line(Point(x, y), Point(x + width, y)))
//    lines.append(Line(Point(x + width, y), Point(x + width, y + height)))
//    lines.append(Line(Point(x, y), Point(x, y + height)))
//    lines.append(Line(Point(x, y + height), Point(x + width, y + height)))
//  }
//}
//
//class LineToPointAdapter: Sequence {
//  private static var count = 0
//  var hash: Int
//
//  // hash of line -> points
//  static var cache = [Int : [Point]]()
//
//  init(_ line: Line) {
//    hash = line.hashValue
//
//    if type(of: self).cache[hash] != nil {
//      return
//    }
//
//    var points = [Point]()
//
//    type(of: self).count += 1
//    print(
//      "\(type(of: self).count): Generating points for line ",
//      "[\(line.start.x),\(line.start.y)]-[\(line.end.x),\(line.end.y)]")
//
//    let left = Swift.min(line.start.x, line.end.x)
//    let right = Swift.max(line.start.x, line.end.x)
//    let top = Swift.min(line.start.y, line.end.y)
//    let bottom = Swift.max(line.start.y, line.end.y)
//    let dx = right - left
//    let dy = line.end.y - line.start.y
//
//    if dx == 0 {
//      for y in top...bottom {
//        points.append(Point(left, y))
//      }
//    } else if dy == 0 {
//      for x in left...right {
//        points.append(Point(x, top))
//      }
//    }
//
//    type(of: self).cache[hash] = points
//  }
//
//  func makeIterator() -> IndexingIterator<Array<Point>>
//  {
//   return IndexingIterator(_elements: type(of: self).cache[hash]!)
//  }
//}
//
//func drawPoint(_ p: Point) {
//  print(".", terminator: "")
//}
//
//let vectorObjects = [
//  VectorRectangle(1, 1, 10, 10),
//  VectorRectangle(3, 3, 6, 6),
//]
//
//func draw() {
//  for vo in vectorObjects {
//    for line in vo {
//      let adapter = LineToPointAdapter(line)
//      adapter.forEach { drawPoint($0) }
//    }
//  }
//}
//
//func main() {
//  draw()
//  draw()
//}
//
//main()
