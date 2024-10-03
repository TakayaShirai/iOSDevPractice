import SwiftUI

struct SearchableView: View {

  private enum LayoutConstant {
    static let mainVStackSpacing: CGFloat = 20.0
    static let eachRestaurantVstackSpacing: CGFloat = 10.0
    static let restaurantRowBackgroundOpacity: CGFloat = 0.05
  }

  private enum LocalizedString {
    static let viewTitle = String(localized: "Restaurants")
    static let searchPlaceHolder = String(localized: "Search Restaurant...")
    static let viewModelSearchingText = String(localized: "ViewModel is searching: ")
  }

  @StateObject private var viewModel = SearchableViewModel()

  var body: some View {
    ScrollView {
      VStack(spacing: LayoutConstant.mainVStackSpacing) {
        ForEach(viewModel.isSearching ? viewModel.filteredRestaurants : viewModel.allRestaurants) {
          restaurant in
          restaurantRow(restaurant: restaurant)
        }
        .padding()

        //      Text(LocalizedString.viewModelSearchingText + "\(viewModel.isSearching.description)")
        //      SearchChildView()
      }
      /// Adds a search bar to the view, which is bound to the searchText property.
      .searchable(
        text: $viewModel.searchText, placement: .automatic,
        prompt: Text(LocalizedString.searchPlaceHolder)
      )
      /// Allows users to filter search results based on categories or scopes.
      .searchScopes(
        $viewModel.searchScope,
        scopes: {
          ForEach(viewModel.allSearchScopes, id: \.self) { scope in
            Text(scope.title)
              .tag(scope)
          }
        }
      )
      /// Provides dynamic search suggestons as the user types.
      .searchSuggestions({
        ForEach(viewModel.getSearchSuggestions(), id: \.self) { suggestion in
          Text(suggestion)
            .searchCompletion(suggestion)
        }
      })
      .navigationTitle(LocalizedString.viewTitle)
      .task {
        await viewModel.loadRestaurants()
      }
    }
  }

  private func restaurantRow(restaurant: Restaurant) -> some View {
    VStack(alignment: .leading, spacing: LayoutConstant.eachRestaurantVstackSpacing) {
      Text(restaurant.title)
        .font(.headline)
      Text(restaurant.cuisine.rawValue.capitalized)
        .font(.caption)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Color.black.opacity(LayoutConstant.restaurantRowBackgroundOpacity))
    .padding()
  }
}

#Preview {
  SearchableView()
}
