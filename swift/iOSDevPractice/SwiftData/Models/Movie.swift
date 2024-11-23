import Foundation
import SwiftData

// The @Model attribute marks this class as a model that can be used with SwiftData.
@Model
final class Movie {
  // No two Movie objects in the database can have the same title.
  //  @Attribute(.unique) var title: String
  var title: String
  var year: Int

  // - deleteRule: .cascade ensures that if a Movie is deleted, all associated reviews are also deleted.
  // - inverse: \Review.movie specifies that the `movie` property in the `Review` class is the inverse relationship.
  // Inverse relationships enable Core Data to propagate change in both directions when an instance of
  // either the source or destination type changes.

  // In the Movie and Review models, the inverse relationship makes sure that:
  // Each Movie can have multiple associated Review objects.
  // Each Review knows which Movie it belongs to.
  @Relationship(deleteRule: .cascade, inverse: \Review.movie)
  var reviews: [Review] = []

  @Relationship(deleteRule: .nullify, inverse: \Actor.movies)
  var actors: [Actor] = []

  init(title: String, year: Int) {
    self.title = title
    self.year = year
  }
}
