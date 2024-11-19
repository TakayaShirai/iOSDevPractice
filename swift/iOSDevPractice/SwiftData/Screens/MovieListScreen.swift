import SwiftData
import SwiftUI

struct MovieListScreen: View {

  private enum LocalizedString {
    static let dismissalButtonTitle = String(localized: "Back")
    static let toolbarTrailingButtonTitle = String(localized: "Add Movie")
  }

  // Declares a property to fetch an array of `Movie` objects from the SwiftData model storage.
  // The @Query property wrapper automatically fetches and updates the `movies` property
  // whenever the underlying data changes or when the query parameters are modified.
  @Query(sort: \Movie.title, order: .forward) private var movies: [Movie]

  @Environment(\.dismiss) private var dismiss

  @State private var isAddMoviePresented: Bool = false

  var body: some View {
    MovieListView(movies: movies)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button {
            dismiss()
          } label: {
            Text(LocalizedString.dismissalButtonTitle)
          }
        }

        ToolbarItem(placement: .topBarTrailing) {
          Button {
            isAddMoviePresented = true
          } label: {
            Text(LocalizedString.toolbarTrailingButtonTitle)
          }
        }
      }
      .sheet(isPresented: $isAddMoviePresented) {
        NavigationStack {
          AddMovieScreen()
        }
      }
  }
}

#Preview {
  NavigationStack {
    MovieListScreen()
      .modelContainer(for: [Movie.self])
  }
}
