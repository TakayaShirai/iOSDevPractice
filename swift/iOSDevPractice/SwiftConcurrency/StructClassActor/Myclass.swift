import Foundation

/// Structs have that default initializer but we have to give them an actual explicit initializer.
class Myclass {
  var title: String

  init(title: String) {
    self.title = title
  }

  func updateTitle(newTitle: String) {
    title = newTitle
  }
}
