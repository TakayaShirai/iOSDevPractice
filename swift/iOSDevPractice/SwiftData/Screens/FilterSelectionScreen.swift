import SwiftUI

enum FilterOption {
  case title(String)
  case reviewsCount(Int)
  case actorsCount(Int)
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
  }

  @Environment(\.dismiss) private var dismiss
  @State private var movieTitle: String = ""
  @State private var numOfReviews: Int?
  @State private var numOfActors: Int?

  @Binding var filterOption: FilterOption

  var body: some View {
    Form {
      titleFilterSection()
      numOfReviewsFilterSection()
      numOfActorsFilterSection()
    }
  }

  @ViewBuilder
  private func titleFilterSection() -> some View {
    Section(LocalizedString.titleFilterTitle) {
      TextField(LocalizedString.movieTitlePlaceholder, text: $movieTitle)
      Button(LocalizedString.searchButtonTitle) {
        filterOption = .title(movieTitle)
        dismiss()
      }
    }
  }

  @ViewBuilder
  private func numOfReviewsFilterSection() -> some View {
    Section(LocalizedString.numOfReviewsFilterTitle) {
      TextField(LocalizedString.numOfReviewsTitlePlaceholder, value: $numOfReviews, format: .number)
        .keyboardType(.numberPad)
      Button(LocalizedString.searchButtonTitle) {
        filterOption = .reviewsCount(numOfReviews ?? 1)
        dismiss()
      }
    }
  }

  @ViewBuilder
  private func numOfActorsFilterSection() -> some View {
    Section(LocalizedString.numOfActorsFilterTitle) {
      TextField(LocalizedString.numOfActorsTitlePlaceholder, value: $numOfActors, format: .number)
        .keyboardType(.numberPad)
      Button(LocalizedString.searchButtonTitle) {
        filterOption = .actorsCount(numOfActors ?? 1)
        dismiss()
      }
    }
  }
}

#Preview {
  FilterSelectionScreen(filterOption: .constant(.title("Batman")))
}
