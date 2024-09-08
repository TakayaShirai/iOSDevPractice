import Foundation

actor MyActor {
  var title: String

  init(title: String) {
    self.title = title
  }

  func updateTitle(newTitle: String) {
    title = newTitle
  }
}
