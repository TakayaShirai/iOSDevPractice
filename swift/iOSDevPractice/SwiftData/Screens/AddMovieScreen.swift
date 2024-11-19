import SwiftData
import SwiftUI

struct AddMovieScreen: View {

  private enum LocalizedString {
    static let title = String(localized: "Title")
    static let year = String(localized: "Year")
    static let close = String(localized: "Close")
    static let save = String(localized: "Save")
    static let navigationTitle = String(localized: "Add Movie")
  }

  @Environment(\.dismiss) private var dismiss
  // Environment variable to access the SwiftData model context.
  @Environment(\.modelContext) private var context

  @State private var title: String = ""
  @State private var year: Int?

  private var isFormValid: Bool {
    !title.isEmptyOrWhitespace && year != nil
  }

  var body: some View {
    Form {
      TextField(LocalizedString.title, text: $title)
      TextField(LocalizedString.year, value: $year, format: .number)
    }
    .navigationTitle(LocalizedString.navigationTitle)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        Button {
          dismiss()
        } label: {
          Text(LocalizedString.close)
        }
      }

      ToolbarItem(placement: .topBarTrailing) {
        Button {
          guard let year = year else { return }
          let movie = Movie(title: title, year: year)

          // Insert the movie into the SwiftData context.
          context.insert(movie)

          do {
            // Save the context to persist the movie.
            // All changes made to the context since the last save are persisted to the database.
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
  }
}

#Preview {
  NavigationStack {
    AddMovieScreen()
      .modelContainer(for: [Movie.self])
  }
}
