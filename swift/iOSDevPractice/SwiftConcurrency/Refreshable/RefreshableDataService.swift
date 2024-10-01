import Foundation

final class RefreshableDataService {

  func getData() async throws -> [String] {
    try? await Task.sleep(nanoseconds: 2_000_000_000)
    return ["Apple", "Orange", "Banana"].shuffled()
  }

}
