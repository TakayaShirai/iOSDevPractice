///// Bridge: A mechanism that decouples an interface (hierarchy) from an implementation (hierarchy).
//
//protocol Renderer {
//  func renderCircle(_ radius: Float)
//}
//
//class VectorRenderer : Renderer {
//  func renderCircle(_ radius: Float) {
//    print("Drawing a circle of radius \(radius)")
//  }
//}
//
//class RasterRenderer : Renderer {
//  func renderCircle(_ radius: Float) {
//    print("Drawing pixels for a circle of radius \(radius)")
//  }
//}
//
//protocol Shape {
//  func draw()
//  func resize(_ factor: Float)
//}
//
///// The great thing about this approach is because we've built a bridge with the renderer, what we can do is we can replace one for another (VectorRenderer, RasterRenderer).
///// So simply, if you want to implement a different rendering implementation, then you can simply use the the other renderer.
///// The key sort of idea from this is that a circle doesn't really know how to draw itself.
///// So the circle doesn't need to make a decision on whether it's going to draw itself
///// in terms of lines and and curves and so on, or whether it's going to draw itself instead of pixels.
//class Circle : Shape {
//  var radius: Float
//  var renderer: Renderer
//
//  init(_ renderer: Renderer, _ radius: Float) {
//    self.renderer = renderer
//    self.radius = radius
//  }
//
//  func draw() {
//    renderer.renderCircle(radius)
//  }
//
//  func resize(_ factor: Float) {
//    radius *= factor
//  }
//}
//
//func main() {
//  let raster = RasterRenderer()
//  let vector = VectorRenderer()
//  let circle = Circle(vector, 5)
//  let circle2 = Circle(raster, 10)
//  circle.draw() // Drawing a circle of radius 5.0
//  circle.resize(2)
//  circle.draw() // Drawing a circle of radius 10.0
//  circle2.draw() // Drawing pixels for a circle of radius 10.0
//}
//
//main()
