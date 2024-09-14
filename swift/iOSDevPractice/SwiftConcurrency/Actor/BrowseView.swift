import SwiftUI

struct BrowseView: View {
  private enum LayoutConstant {
    static let yellowColorOpacity: CGFloat = 0.8
  }

  @State private var text: String = ""
  let manager = MyActorDataManager.instance
  let timer = Timer.publish(every: 0.01, tolerance: nil, on: .main, in: .common, options: nil)
    .autoconnect()

  var body: some View {
    ZStack {
      Color.yellow.opacity(LayoutConstant.yellowColorOpacity).ignoresSafeArea()

      Text(text)
        .font(.headline)
    }
    .onReceive(timer) { _ in
      Task {
        if let data = await manager.getRandomData() {
          await MainActor.run {
            self.text = data
          }
        }
      }
      //      DispatchQueue.global(qos: .default).async {
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
  BrowseView()
}
