import Foundation
import SwiftData

// The @Model attribute marks this class as a model that can be used with SwiftData.
@Model
final class Movie {
  // No two Movie objects in the database can have the same title.
  //  @Attribute(.unique) var title: String
  var title: String
  var year: Int

  init(title: String, year: Int) {
    self.title = title
    self.year = year
  }
}
