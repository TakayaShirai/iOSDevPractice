import SwiftUI

struct AsyncPublisherView: View {

  @StateObject private var viewModel = AsyncPublisherViewModel()

  var body: some View {
    ScrollView {
      VStack {
        ForEach(viewModel.dataArray, id: \.self) {
          Text($0)
            .font(.headline)
        }
      }
    }
    .task {
      await viewModel.start()
    }
  }
}

#Preview {
  AsyncPublisherView()
}