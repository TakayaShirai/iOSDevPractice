import Foundation

// Immutable struct
struct CustomStruct {
  let title: String

  func updateTitle(newTitle: String) -> CustomStruct {
    return CustomStruct(title: newTitle)
  }
}
