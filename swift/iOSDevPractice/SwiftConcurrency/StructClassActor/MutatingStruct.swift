import Foundation

struct MutatingStruct {
  private(set) var title: String

  init(title: String) {
    self.title = title
  }

  /// Mutating is for value types. Mutating means we are going to take the current values. we're gonna change them.
  /// we're gonna create a new object with new values.
  /// we are gonna actually change this entire object when we change this title. we are not just changing the value of the title.
  mutating func updateTitle(newTitle: String) {
    title = newTitle
  }
}
