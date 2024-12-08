import SwiftData
import SwiftUI

struct MovieDetailScreen: View {

  private enum LocalizedString {
    static let title = String(localized: "Title")
    static let year = String(localized: "Year")
    static let update = String(localized: "Update")
    static let reviewSectionTitle = String(localized: "Reviews")
    static let actorSectionTitle = String(localized: "Actors")
    static let noReviewsText = String(localized: "No reviews yet")
    static let noActorsText = String(localized: "No actors available")
  }

  @Environment(\.modelContext) private var context
  @Environment(\.dismiss) private var dismiss
  let movie: Movie

  @State private var title: String = ""
  @State private var year: Int?
  @State private var showReviewScreen: Bool = false

  var body: some View {
    Form {
      newMovieTextFields()

      updateMovieButton()

      reviewsSection()
      actorsSection()
    }
    .onAppear {
      title = movie.name
      year = movie.year
    }
    .sheet(isPresented: $showReviewScreen) {
      NavigationStack {
        AddReviewScreen(movie: movie)
      }
    }
  }

  @ViewBuilder
  private func newMovieTextFields() -> some View {
    TextField(LocalizedString.title, text: $title)
    TextField(LocalizedString.year, value: $year, format: .number)
  }

  @ViewBuilder
  private func updateMovieButton() -> some View {
    Button {
      guard let year = year else { return }

      movie.name = title
      movie.year = year

      do {
        try context.save()
      } catch {
        print(error.localizedDescription)
      }

      dismiss()

    } label: {
      Text(LocalizedString.update)
    }
    .buttonStyle(.borderless)
  }

  @ViewBuilder
  private func reviewsSection() -> some View {
    Section(LocalizedString.reviewSectionTitle) {
      Button {
        showReviewScreen = true
      } label: {
        Image(systemName: "plus")
          .frame(maxWidth: .infinity, alignment: .trailing)
      }

      if movie.reviews.isEmpty {
        ContentUnavailableView {
          Text(LocalizedString.noReviewsText)
        }
      } else {
        ReviewListView(movie: movie)
      }
    }
  }

  @ViewBuilder
  private func actorsSection() -> some View {
    Section(LocalizedString.actorSectionTitle) {
      if movie.actors.isEmpty {
        ContentUnavailableView {
          Text(LocalizedString.noActorsText)
        }
      } else {
        List(movie.actors) { actor in
          ActorCellView(actor: actor)
        }
      }
    }
  }
}

struct MovieDetailContainerScreen: View {

  @Environment(\.modelContext) private var context
  @State private var movie: Movie?

  var body: some View {
    ZStack {
      if let movie {
        MovieDetailScreen(movie: movie)
      }
    }
    .onAppear {
      movie = Movie(name: "Sample", year: 2020)
      context.insert(movie!)

      do {
        try context.save()
      } catch {
        print(error.localizedDescription)
      }
    }

  }
}

#Preview {
  MovieDetailContainerScreen()
    .modelContainer(for: [Movie.self])
}
