import SwiftUI

struct SearchChildView: View {
  private enum LocalizedString {
    static let isSearchingText = String(localized: "Child View is searching: ")
  }

  @Environment(\.isSearching) private var isSearching

  var body: some View {
    Text(LocalizedString.isSearchingText + "\(isSearching)")
  }
}

#Preview {
  SearchChildView()
}
