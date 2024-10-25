///// Motivation: Balancing complexity and presentation/usability
///// Typical home
///// - Many subsystems (electrical, sanitation)
///// - Complex internal structure (e.g., floor layers)
///// - End user is not exposed to internals
///// Same with software
///// - Many systems working to provide flexibility but consumers want it to just work
//
///// Façade: Provides a simple, easy to understand/user interface over a large and sophistcated body of code.
//
//import Foundation
//
//class Buffer {
//  var width, height: Int
//  var buffer: [Character]
//
//  init(width: Int, height: Int) {
//    self.width = width
//    self.height = height
//    buffer = [Character](repeating: " ", count: width*height)
//  }
//
//  subscript(_ index: Int) -> Character {
//    return buffer[index]
//  }
//}
//
//class Viewport {
//  var buffer: Buffer
//  var offset = 0
//
//  init(buffer: Buffer) {
//    self.buffer = buffer
//  }
//
//  func getCharacterAt(_ index: Int) -> Character {
//    return buffer[offset+index]
//  }
//}
//
//class Console {
//  var buffers = [Buffer]()
//  var viewports = [Viewport]()
//  var offset = 0
//
//  init() {
//    let b = Buffer(width: 30, height: 20)
//    let v = Viewport(buffer: b)
//    buffers.append(b)
//    viewports.append(v)
//  }
//
//  func getCharacterAt(_ index: Int) -> Character {
//    return viewports[0].getCharacterAt(index)
//  }
//}
//
///// The benefit is that the user that works with the console doesn't have to initialize all of these lowlevel complicated objects.
///// They don't have to work with buffers, they don't have to work with viewports. They can just make a console.
//func main() {
//  let c = Console()
//  let u = c.getCharacterAt(1)
//}
//
//main()
