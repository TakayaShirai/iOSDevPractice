import SwiftData
import SwiftUI

struct SwiftDataPracticeView: View {
  var body: some View {
    MovieListScreen()
      .modelContainer(for: [Movie.self, Actor.self, Review.self])
  }
}

#Preview {
  NavigationStack {
    SwiftDataPracticeView()
  }
}
