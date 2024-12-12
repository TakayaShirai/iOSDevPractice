import SwiftData
import SwiftUI

struct AddMovieScreen: View {

  private enum LocalizedString {
    static let title = String(localized: "Title")
    static let year = String(localized: "Year")
    static let close = String(localized: "Close")
    static let save = String(localized: "Save")
    static let navigationTitle = String(localized: "Add Movie")
    static let sectionTitle = String(localized: "Select Actors")
    static let genreSelectionTitle = String(localized: "Select Genre")
  }

  @Environment(\.dismiss) private var dismiss
  // Environment variable to access the SwiftData model context.
  @Environment(\.modelContext) private var context

  @State private var genre: Genre = .action
  @State private var name: String = ""
  @State private var year: Int?
  @State private var selectedActors: Set<Actor> = []

  private var isFormValid: Bool {
    !name.isEmptyOrWhitespace && year != nil && !selectedActors.isEmpty
  }

  var body: some View {
    Form {
      genreSelectionSection()
      newMovieTextFields()
      actorSelectionSection()
    }
    .navigationTitle(LocalizedString.navigationTitle)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        dismissalButton()
      }

      ToolbarItem(placement: .topBarTrailing) {
        saveMovieButton()
      }
    }
  }

  @ViewBuilder
  private func genreSelectionSection() -> some View {
    Picker(LocalizedString.genreSelectionTitle, selection: $genre) {
      ForEach(Genre.allCases) { genre in
        Text(genre.title).tag(genre)
      }
    }
    .pickerStyle(.segmented)
  }

  @ViewBuilder
  private func newMovieTextFields() -> some View {
    TextField(LocalizedString.title, text: $name)
    TextField(LocalizedString.year, value: $year, format: .number)
  }

  @ViewBuilder
  private func actorSelectionSection() -> some View {
    Section(LocalizedString.sectionTitle) {
      ActorSelectionView(selectedActors: $selectedActors)
    }
  }

  @ViewBuilder
  private func dismissalButton() -> some View {
    Button {
      dismiss()
    } label: {
      Text(LocalizedString.close)
    }
  }

  @ViewBuilder
  private func saveMovieButton() -> some View {
    Button {
      guard let year = year else { return }

      let movie = Movie(name: name, year: year, genre: genre)
      movie.actors = Array(selectedActors)

      selectedActors.forEach { actor in
        actor.movies.append(movie)
        context.insert(actor)

        do {
          try context.save()
        } catch {
          print(error.localizedDescription)
        }
      }

      // Insert the movie into the SwiftData context.
      context.insert(movie)

      do {
        try context.save()
      } catch {
        print(error.localizedDescription)
      }

      dismiss()
    } label: {
      Text(LocalizedString.save)
    }
    .disabled(!isFormValid)
  }
}

#Preview {
  NavigationStack {
    AddMovieScreen()
      .modelContainer(for: [Movie.self])
  }
}
