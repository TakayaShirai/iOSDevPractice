import SwiftData
import SwiftUI

struct SwiftDataPracticeView: View {
  let container: ModelContainer

  init() {
    do {
      // for: A list of the persistent model types that comprise your app’s schema.
      // migrationPlan: A plan that describes the evolution of your app’s schema and how the container migrates between specific versions.
      // configuration: A list configurations that describe how the container manages the persisted data for specific groups of models.
      container = try ModelContainer(
        for: Movie.self, migrationPlan: MoviesMigrationPlan.self,
        configurations: ModelConfiguration(for: Movie.self))
    } catch {
      fatalError("Could not initialize the container.")
    }
  }

  var body: some View {
    MovieListScreen()
      .modelContainer(container)
  }
}

#Preview {
  NavigationStack {
    SwiftDataPracticeView()
  }
}
