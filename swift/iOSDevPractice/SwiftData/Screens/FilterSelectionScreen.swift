import SwiftUI

enum FilterOption {
  case title(String)
  case reviewsCount(Int)
  case actorsCount(Int)
  case genre(Genre)
  case none
}

struct FilterSelectionScreen: View {

  private enum LocalizedString {
    static let titleFilterTitle = String(localized: "Filter by title")
    static let movieTitlePlaceholder = String(localized: "Movie title")
    static let numOfReviewsFilterTitle = String(localized: "Filter by number of reviews")
    static let numOfReviewsTitlePlaceholder = String(localized: "Number of reviews")
    static let numOfActorsFilterTitle = String(localized: "Filter by number of actors")
    static let numOfActorsTitlePlaceholder = String(localized: "Number of actors")
    static let searchButtonTitle = String(localized: "Search")
    static let genreFilterTitle = String(localized: "Filter by genre")
    static let genreSelectionTitle = String(localized: "Select a genre")
  }

  @Environment(\.dismiss) private var dismiss
  @Binding var filterSelectionConfig: FilterSelectionConfig

  var body: some View {
    Form {
      titleFilterSection()
      numOfReviewsFilterSection()
      numOfActorsFilterSection()
      genreFilterSection()
    }
  }

  @ViewBuilder
  private func titleFilterSection() -> some View {
    Section(LocalizedString.titleFilterTitle) {
      TextField(LocalizedString.movieTitlePlaceholder, text: $filterSelectionConfig.movieTitle)
      Button(LocalizedString.searchButtonTitle) {
        filterSelectionConfig.filterOption = .title(filterSelectionConfig.movieTitle)
        dismiss()
      }
    }
  }

  @ViewBuilder
  private func numOfReviewsFilterSection() -> some View {
    Section(LocalizedString.numOfReviewsFilterTitle) {
      TextField(
        LocalizedString.numOfReviewsTitlePlaceholder, value: $filterSelectionConfig.numOfReviews,
        format: .number
      )
      .keyboardType(.numberPad)
      Button(LocalizedString.searchButtonTitle) {
        filterSelectionConfig.filterOption = .reviewsCount(filterSelectionConfig.numOfReviews ?? 1)
        dismiss()
      }
    }
  }

  @ViewBuilder
  private func numOfActorsFilterSection() -> some View {
    Section(LocalizedString.numOfActorsFilterTitle) {
      TextField(
        LocalizedString.numOfActorsTitlePlaceholder, value: $filterSelectionConfig.numOfActors,
        format: .number
      )
      .keyboardType(.numberPad)
      Button(LocalizedString.searchButtonTitle) {
        filterSelectionConfig.filterOption = .actorsCount(filterSelectionConfig.numOfActors ?? 1)
        dismiss()
      }
    }
  }

  @ViewBuilder
  private func genreFilterSection() -> some View {
    Section(LocalizedString.genreFilterTitle) {
      Picker(LocalizedString.genreSelectionTitle, selection: $filterSelectionConfig.genre) {
        ForEach(Genre.allCases) { genre in
          Text(genre.title).tag(genre)
        }
      }
      .onChange(of: filterSelectionConfig.genre) { oldValue, newValue in
        filterSelectionConfig.filterOption = .genre(newValue)
        dismiss()
      }
    }
  }
}

#Preview {
  FilterSelectionScreen(filterSelectionConfig: .constant(FilterSelectionConfig()))
}
