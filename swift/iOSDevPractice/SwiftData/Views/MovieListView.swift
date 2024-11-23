import SwiftData
import SwiftUI

struct MovieListView: View {

  let movies: [Movie]

  @Environment(\.modelContext) private var context

  private func deleteMovie(indexSet: IndexSet) {
    indexSet.forEach { index in
      let movie = movies[index]

      context.delete(movie)

      do {
        try context.save()
      } catch {
        print(error.localizedDescription)
      }
    }
  }

  var body: some View {
    List {
      ForEach(movies) { movie in
        NavigationLink(value: movie) {
          movieDetail(movie)
        }
      }
      .onDelete(perform: deleteMovie)
    }
    .navigationDestination(for: Movie.self) { movie in
      MovieDetailScreen(movie: movie)
        .modelContainer(for: [Movie.self, Actor.self, Review.self])
    }
  }

  @ViewBuilder
  private func movieDetail(_ movie: Movie) -> some View {
    HStack {
      Text(movie.title)
      Spacer()
      Text(movie.year.description)
    }
  }
}

#Preview {
  MovieListView(movies: [])
    .modelContainer(for: [Movie.self])
}
