import SwiftUI

struct AsyncStreamView: View {

  @StateObject private var viewModel = AsyncStreamViewModel()

  var body: some View {
    Text("\(viewModel.currentNumber)")
      .onAppear {
        viewModel.onViewAppear()
      }
  }
}

#Preview {
  AsyncStreamView()
}
