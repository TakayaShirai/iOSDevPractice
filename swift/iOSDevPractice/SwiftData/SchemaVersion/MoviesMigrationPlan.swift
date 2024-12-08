import Foundation
import SwiftData

// SchemaMigrationPlan: An interface for describing the evolution of a schema and how to migrate between specific versions.
// Handles changes like adding, removing, or modifying fields in a data model and ensures that existing data is migrated safely during these updates.
enum MoviesMigrationPlan: SchemaMigrationPlan {

  static var schemas: [any VersionedSchema.Type] {
    [MoviesSchemaV1.self, MoviesSchemaV2.self, MoviesSchemaV3.self]
  }

  // The stages property defines the actual steps or stages to migrate between schema versions.
  // It maps a specific migration, in this case, migrateV1ToV2, to handle changes from MoviesSchemaV1 to MoviesSchemaV2
  static var stages: [MigrationStage] {
    [migrateV1toV2, migrateV2toV3]
  }

  // Defines the custom logic for transitioning data between MoviesSchemaV1 and MoviesSchemaV2.
  static let migrateV1toV2 = MigrationStage.custom(
    fromVersion: MoviesSchemaV1.self, toVersion: MoviesSchemaV2.self,
    willMigrate: { context in
      // Retrieves all Movie objects from the database using FetchDescriptor.
      guard let movies = try? context.fetch(FetchDescriptor<Movie>()) else { return }

      var duplicates = Set<Movie>()
      var uniqueSet = Set<String>()

      for movie in movies {
        if !uniqueSet.insert(movie.name).inserted {
          duplicates.insert(movie)
        }
      }

      for movie in duplicates {
        guard let movieToBeUpdated = movies.first(where: { $0.id == movie.id }) else { continue }
        movieToBeUpdated.name = movieToBeUpdated.name + " \(UUID().uuidString)"
      }

      try? context.save()

    }, didMigrate: nil)

  static let migrateV2toV3 = MigrationStage.lightweight(
    fromVersion: MoviesSchemaV2.self, toVersion: MoviesSchemaV3.self)

}
