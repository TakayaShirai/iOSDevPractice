import Combine
import Foundation

@MainActor
final class SearchableViewModel: ObservableObject {

  private enum LocalizedString {
    static let searchOptionTitleForAll = String(localized: "All")
  }

  @Published private(set) var allRestaurants: [Restaurant] = []
  @Published private(set) var filteredRestaurants: [Restaurant] = []
  @Published var searchText: String = ""
  @Published var searchScope: SearchScopeOption = .all
  @Published private(set) var allSearchScopes: [SearchScopeOption] = []

  let manager = RestaurantManager()
  private var cancellables = Set<AnyCancellable>()

  var isSearching: Bool {
    !searchText.isEmpty
  }

  var showSearchSuggestion: Bool {
    searchText.count < 1
  }

  enum SearchScopeOption: Hashable {
    case all
    case cuisine(option: CuisineOption)

    var title: String {
      switch self {
      case .all:
        return LocalizedString.searchOptionTitleForAll
      case .cuisine(let option):
        return option.rawValue.capitalized
      }
    }
  }

  init() {
    addSubscribers()
  }

  private func addSubscribers() {
    $searchText
      /// Whenever, either searchText or searchScope change, the combined tuple will be emitted.
      .combineLatest($searchScope)
      /// debounce is used to dalay the emmission of values by a specified amount of time.
      /// This is useful in situations like a search bar where you don't want to trigger the search immediately on every keystroke but wait for a brief pause in input.
      .debounce(for: 0.3, scheduler: DispatchQueue.main)
      .sink { [weak self] (searchText, searchScope) in
        self?.filterRestaurants(searchText: searchText, currentSearchScope: searchScope)
      }
      .store(in: &cancellables)
  }

  private func filterRestaurants(searchText: String, currentSearchScope: SearchScopeOption) {
    guard !searchText.isEmpty else {
      filteredRestaurants = []
      searchScope = .all
      return
    }

    // Filter on search scope
    var restaurantsInScope = allRestaurants
    switch currentSearchScope {
    case .all:
      break
    case .cuisine(let option):
      restaurantsInScope = allRestaurants.filter({ $0.cuisine == option })
    }

    // Filter on search text
    let search = searchText.lowercased()
    filteredRestaurants = restaurantsInScope.filter({ restaurant in
      let titleContainsSearch = restaurant.title.lowercased().contains(search)
      let cuisineContainsSearch = restaurant.cuisine.rawValue.lowercased().contains(search)
      return titleContainsSearch || cuisineContainsSearch
    })
  }

  func loadRestaurants() async {
    do {
      allRestaurants = try await manager.getAllRestaurants()

      let allCuisines = Set(allRestaurants.map { $0.cuisine })
      allSearchScopes = [.all] + allCuisines.map({ SearchScopeOption.cuisine(option: $0) })
    } catch {
      print(error)
    }
  }

  func getSearchSuggestions() -> [String] {
    guard showSearchSuggestion else { return [] }

    var suggestions: [String] = []

    let search = searchText.lowercased()
    if search.contains("pa") {
      suggestions.append("Pasta")
    }
    if search.contains("su") {
      suggestions.append("Sushi")
    }
    if search.contains("bu") {
      suggestions.append("Burger")
    }
    suggestions.append("Market")
    suggestions.append("Grocery")

    suggestions.append(CuisineOption.italian.rawValue.capitalized)
    suggestions.append(CuisineOption.american.rawValue.capitalized)
    suggestions.append(CuisineOption.japanese.rawValue.capitalized)

    return suggestions
  }

  func getRestaurantSuggestions() -> [Restaurant] {
    guard showSearchSuggestion else { return [] }

    var suggestions: [Restaurant] = []

    let search = searchText.lowercased()

    if search.contains("ita") {
      suggestions.append(contentsOf: allRestaurants.filter({ $0.cuisine == .italian }))
    }

    if search.contains("jap") {
      suggestions.append(contentsOf: allRestaurants.filter({ $0.cuisine == .japanese }))
    }

    return suggestions
  }
}
