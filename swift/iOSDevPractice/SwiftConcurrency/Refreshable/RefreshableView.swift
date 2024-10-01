import SwiftUI

struct RefreshableView: View {

  private enum LocalizedString {
    static let navigationTitle = String(localized: "Refreshable")
  }

  @StateObject private var viewModel = RefreshableViewModel()

  var body: some View {
    ScrollView {
      VStack {
        ForEach(viewModel.items, id: \.self) { item in
          Text(item)
            .font(.headline)
        }
      }
    }
    /// The `refreshable` modifier can be used with synchronous code, but it is primarily designed for asynchronous operations.
    /// When used asynchronously, the spinner remains visible until the operation completes, enhancing the user experience.
    /// However, with synchronous code, the spinner may disappear too quickly, potentially impairing the user experience.
    .refreshable {
      await viewModel.loadData()
    }
    .navigationTitle(LocalizedString.navigationTitle)
    .task {
      await viewModel.loadData()
    }
  }
}

#Preview {
  RefreshableView()
}
