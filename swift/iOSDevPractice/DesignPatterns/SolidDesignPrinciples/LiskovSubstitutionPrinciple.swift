///// You should always be able to substitute a base type for a subtype.
//import Foundation
//
//class Rectangle : CustomStringConvertible
//{
//  var _width: Int = 0
//  var _height: Int = 0
//  
//  var width: Int
//  {
//    get {
//      return _width
//    }
//    set(value) {
//      _width = value
//    }
//  }
//  
//  var height: Int
//  {
//    get {
//      return _height
//    }
//    set(value) {
//      _height = value
//    }
//  }
//  
//  var area: Int {
//    height * width
//  }
//
//  init() {}
//  init(_ width: Int, _ height: Int)
//  {
//    _width = width
//    _height = height
//  }
//
//  public var description: String
//  {
//    return "Width: \(width), height: \(height)"
//  }
//}
//
//class Square : Rectangle
//{
//  override var height: Int
//  {
//    get { return _height }
//    set(value)
//    {
//      _width = value
//      _height = value
//    }
//  }
//  
//  override var width: Int
//  {
//    get { return _width }
//    set(value)
//    {
//      _width = value
//      _height = value
//    }
//  }
//}
//
//func setAndMeasure(_ rc: Rectangle) {
//  rc.width = 3
//  rc.height = 4
//  print("Expected area to be 12 but got \(rc.area)")
//}
//
//func main()
//{
//  let rc = Rectangle()
//  setAndMeasure(rc) // Expected area to be 12 but got 12
//
//  /// should be able to substitute a base type for a subtype
//  /// LSP stipulates that you should be able to use derived classes without knowing anything about their explicit mechanics.
//  /// Setting sizes and then getting the expected result should work because that's what you would generally expect a rectangle to behave like
//  /// bad example
//  let sq = Square()
//  setAndMeasure(sq) // Expected area to be 12 but got 16"
//}
//
////main()
