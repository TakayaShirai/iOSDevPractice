import Foundation

struct Restaurant: Identifiable, Hashable {
  let id: String
  let title: String
  let cuisine: CuisineOption
}

final class RestaurantManager {
  func getAllRestaurants() async throws -> [Restaurant] {
    [
      Restaurant(id: "1", title: "Burger Shack", cuisine: .american),
      Restaurant(id: "2", title: "Pasta Palace", cuisine: .italian),
      Restaurant(id: "3", title: "Sushi Heaven", cuisine: .japanese),
      Restaurant(id: "4", title: "Local market", cuisine: .american),
    ]
  }
}

enum CuisineOption: String {
  case american, italian, japanese
}
