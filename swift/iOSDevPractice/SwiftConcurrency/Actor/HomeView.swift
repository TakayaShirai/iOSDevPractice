import SwiftUI

struct HomeView: View {
  private enum LayoutConstant {
    static let grayColorOpacity: CGFloat = 0.8
  }

  @State private var text: String = ""
  let manager = MyActorDataManager.instance
  let timer = Timer.publish(every: 0.1, tolerance: nil, on: .main, in: .common, options: nil)
    .autoconnect()

  var body: some View {
    ZStack {
      Color.gray.opacity(LayoutConstant.grayColorOpacity).ignoresSafeArea()

      Text(text)
        .font(.headline)
    }
    .onAppear {
      let newString = manager.getSavedData()
      print(newString)
    }
    .onReceive(timer) { _ in
      Task {
        if let data = await manager.getRandomData() {
          await MainActor.run {
            self.text = data
          }
        }
      }
      //      DispatchQueue.global(qos: .background).async {
      //        manager.getRandomData { title in
      //          if let data = title {
      //            DispatchQueue.main.async {
      //              self.text = data
      //            }
      //          }
      //        }
      //      }
    }
  }
}

#Preview {
  HomeView()
}
