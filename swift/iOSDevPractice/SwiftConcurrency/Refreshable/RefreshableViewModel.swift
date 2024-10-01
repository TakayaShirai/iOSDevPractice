import Foundation

@MainActor
final class RefreshableViewModel: ObservableObject {
  @Published private(set) var items: [String] = []
  let manager = RefreshableDataService()

  func loadData() async {
    do {
      items = try await manager.getData()
    } catch {
      print(error)
    }
  }
}
