import SwiftData
import SwiftUI

enum Sheets: Identifiable {
  case addMovie
  case addActor
  case showFilter

  var id: Int {
    hashValue
  }
}

struct MovieListScreen: View {

  private enum LayoutConstant {
    static let actorBottomSheetFraction: CGFloat = 0.25
  }

  private enum LocalizedString {
    static let moviesTitle = String(localized: "Movies")
    static let filterTitle = String(localized: "Filter")
    static let actorsTitle = String(localized: "Actors")
    static let dismissalButtonTitle = String(localized: "Back")
    static let toolbarTrailingButtonTitle = String(localized: "Add Movie")
    static let toolbarLeadingButtonTitle = String(localized: "Add Actor")
    static let textFieldPlaceholder = String(localized: "Actor name")
    static let saveButtonText = String(localized: "Save")
  }

  // Declares a property to fetch an array of `Movie` objects from the SwiftData model storage.
  // The @Query property wrapper automatically fetches and updates the `movies` property
  // whenever the underlying data changes or when the query parameters are modified.
  @Query(
    filter: #Predicate<Movie> { movie in
      movie.name.contains("Batman")
    })
  private var movies: [Movie]
  @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]

  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var context

  @State private var actorName: String = ""
  @State private var activeSheet: Sheets?
  @State private var filterOption: FilterOption = .none

  private func saveActor() {
    let actor = Actor(name: actorName)
    context.insert(actor)

    do {
      try context.save()
    } catch {
      print(error.localizedDescription)
    }
  }

  var body: some View {
    VStack(alignment: .leading) {
      moviesListHeader()
      MovieListView(filterOption: filterOption)
        .modelContainer(for: [Movie.self, Actor.self, Review.self])

      actorsListTitle()
      ActorListView(actors: actors)
        .modelContainer(for: [Movie.self, Actor.self, Review.self])
    }
    .padding()
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        addActorButton()
      }
      ToolbarItem(placement: .topBarTrailing) {
        addMovieButton()
      }
    }
    .sheet(item: $activeSheet) { activeSheet in
      switch activeSheet {
      case .addMovie:
        NavigationStack {
          AddMovieScreen()
        }
      case .addActor:
        NavigationStack {
          actorBottomSheetTitle()
          newActorTextField()
          saveActorButton()
        }
      case .showFilter:
        FilterSelectionScreen(filterOption: $filterOption)
      }
    }
  }

  @ViewBuilder
  private func moviesListTitle() -> some View {
    Text(LocalizedString.moviesTitle)
      .font(.largeTitle)
  }

  @ViewBuilder
  private func moviesListFilter() -> some View {
    Button(LocalizedString.filterTitle) {
      activeSheet = .showFilter
    }
  }

  @ViewBuilder
  private func moviesListHeader() -> some View {
    HStack(alignment: .firstTextBaseline) {
      moviesListTitle()
      Spacer()
      moviesListFilter()
    }
  }

  @ViewBuilder
  private func actorsListTitle() -> some View {
    Text(LocalizedString.actorsTitle)
      .font(.largeTitle)
  }

  @ViewBuilder
  private func addActorButton() -> some View {
    Button {
      activeSheet = .addActor
    } label: {
      Text(LocalizedString.toolbarLeadingButtonTitle)
    }
  }

  @ViewBuilder
  private func addMovieButton() -> some View {
    Button {
      activeSheet = .addMovie
    } label: {
      Text(LocalizedString.toolbarTrailingButtonTitle)
    }
  }

  @ViewBuilder
  private func actorBottomSheetTitle() -> some View {
    Text(LocalizedString.toolbarLeadingButtonTitle)
      .font(.largeTitle)
  }

  @ViewBuilder
  private func newActorTextField() -> some View {
    TextField(LocalizedString.textFieldPlaceholder, text: $actorName)
      .textFieldStyle(.roundedBorder)
      .presentationDetents([.fraction(LayoutConstant.actorBottomSheetFraction)])
      .padding()
  }

  @ViewBuilder
  private func saveActorButton() -> some View {
    Button {
      saveActor()
      self.activeSheet = nil
    } label: {
      Text(LocalizedString.saveButtonText)
    }
  }
}

#Preview {
  NavigationStack {
    MovieListScreen()
      .modelContainer(for: [Movie.self])
  }
}
