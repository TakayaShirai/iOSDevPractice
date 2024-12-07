import SwiftData
import SwiftUI

struct MovieListView: View {

  private enum LocalizedString {
    static let numOfReviewsText = String(localized: "Number of reviews:")
    static let numOfActorsText = String(localized: "Number of actors:")
  }

  @Query private var movies: [Movie]
  let filterOption: FilterOption

  init(filterOption: FilterOption = .none) {
    self.filterOption = filterOption

    switch self.filterOption {
    case .title(let movieTitle):
      _movies = Query(
        filter: #Predicate { movie in
          movie.title.contains(movieTitle)
        })
    case .reviewsCount(let numberOfReviews):
      _movies = Query(filter: #Predicate { $0.reviews.count >= numberOfReviews })
    case .actorsCount(let numberOfActors):
      _movies = Query(filter: #Predicate { $0.actors.count >= numberOfActors })
    case .none:
      _movies = Query()
    }
  }

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
    HStack(alignment: .firstTextBaseline) {
      VStack(alignment: .leading) {
        Text(movie.title)
        Text("\(LocalizedString.numOfReviewsText) \(movie.reviewsCount)")
          .font(.caption)
        Text("\(LocalizedString.numOfActorsText) \(movie.actorsCount)")
          .font(.caption)
      }
      Spacer()
      Text(movie.year.description)
    }
  }
}

#Preview {
  MovieListView(filterOption: .none)
    .modelContainer(for: [Movie.self])
}
