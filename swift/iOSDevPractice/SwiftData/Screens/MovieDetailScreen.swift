import SwiftData
import SwiftUI

struct MovieDetailScreen: View {

  private enum LocalizedString {
    static let title = String(localized: "Title")
    static let year = String(localized: "Year")
    static let update = String(localized: "Update")
    static let sectionTitle = String(localized: "Reviews")
    static let noReviewsText = String(localized: "No reviews yet")
  }

  @Environment(\.modelContext) private var context
  @Environment(\.dismiss) private var dismiss
  let movie: Movie

  @State private var title: String = ""
  @State private var year: Int?
  @State private var showReviewScreen: Bool = false

  var body: some View {
    Form {
      TextField(LocalizedString.title, text: $title)
      TextField(LocalizedString.year, value: $year, format: .number)

      Button {
        guard let year = year else { return }

        movie.title = title
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

      Section(LocalizedString.sectionTitle) {
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
    .onAppear {
      title = movie.title
      year = movie.year
    }
    .sheet(isPresented: $showReviewScreen) {
      NavigationStack {
        AddReviewScreen(movie: movie)
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
      movie = Movie(title: "Sample", year: 2020)
      context.insert(movie!)
    }

  }
}

#Preview {
  MovieDetailContainerScreen()
    .modelContainer(for: [Movie.self])
}
