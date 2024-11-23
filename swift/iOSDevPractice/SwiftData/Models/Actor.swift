import Foundation
import SwiftData

@Model
final class Actor {

  var name: String
  var movies: [Movie] = []

  init(name: String) {
    self.name = name
  }
}
