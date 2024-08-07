import SwiftUI

struct DoCatchTryThrowsView: View {
  @StateObject private var viewModel = DoCatchTryThrowsViewModel()
  
  var body: some View {
    Text(viewModel.text)
      .frame(width: 350, height: 350)
      .background(Color(.green))
      .foregroundStyle(Color(.white))
      .onTapGesture {
        viewModel.fetchTitle()
      }
  }
}

#Preview {
  DoCatchTryThrowsView()
}
