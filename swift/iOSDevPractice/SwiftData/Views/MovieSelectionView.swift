import SwiftData
import SwiftUI

struct MovieSelectionView: View {

  @Query(sort: \Movie.name, order: .forward) private var movies: [Movie]
  @Binding var selectedMovies: Set<Movie>

  var body: some View {
    List(movies) { movie in
      HStack {
        checkBox(movie)
        movieTitle(movie)
      }
    }
  }

  @ViewBuilder
  private func checkBox(_ movie: Movie) -> some View {
    Image(systemName: selectedMovies.contains(movie) ? "checkmark.square" : "square")
      .onTapGesture {
        if !selectedMovies.contains(movie) {
          selectedMovies.insert(movie)
        } else {
          selectedMovies.remove(movie)
        }
      }
  }

  @ViewBuilder
  private func movieTitle(_ movie: Movie) -> some View {
    Text(movie.name)
  }
}
