import SwiftUI

struct MVVMView: View {

  @StateObject private var viewModel = MVVMViewModel()

  var body: some View {
    VStack {
      Button {
        viewModel.onCallToActionButtonPressed()
      } label: {
        Text(viewModel.myData)
      }
    }
    .onDisappear {

    }
  }
}

#Preview {
  MVVMView()
}
