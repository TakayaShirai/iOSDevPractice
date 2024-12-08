import Foundation
import SwiftData

enum MoviesSchemaV1: VersionedSchema {

  static var versionIdentifier: Schema.Version = Schema.Version(1, 0, 0)

  static var models: [any PersistentModel.Type] {
    [Movie.self]
  }

  // The @Model attribute marks this class as a model that can be used with SwiftData.
  @Model
  final class Movie {

    var title: String
    var year: Int

    var reviewsCount: Int {
      reviews.count
    }

    var actorsCount: Int {
      actors.count
    }

    @Relationship(deleteRule: .cascade, inverse: \Review.movie)
    var reviews: [Review] = []

    @Relationship(deleteRule: .nullify, inverse: \Actor.movies)
    var actors: [Actor] = []

    init(title: String, year: Int) {
      self.title = title
      self.year = year
    }
  }
}

enum MoviesSchemaV2: VersionedSchema {
  static var versionIdentifier: Schema.Version = Schema.Version(2, 0, 0)

  static var models: [any PersistentModel.Type] {
    [Movie.self]
  }

  @Model
  final class Movie {

    // No two Movie objects in the database can have the same title.
    @Attribute(.unique) var title: String
    var year: Int

    var reviewsCount: Int {
      reviews.count
    }

    var actorsCount: Int {
      actors.count
    }

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
}

enum MoviesSchemaV3: VersionedSchema {
  static var versionIdentifier: Schema.Version = Schema.Version(3, 0, 0)

  static var models: [any PersistentModel.Type] {
    [Movie.self]
  }

  @Model
  final class Movie {

    // No two Movie objects in the database can have the same title.
    @Attribute(.unique, originalName: "title") var name: String
    var year: Int

    var reviewsCount: Int {
      reviews.count
    }

    var actorsCount: Int {
      actors.count
    }

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

    init(name: String, year: Int) {
      self.name = name
      self.year = year
    }
  }

}
