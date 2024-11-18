import SwiftUI

struct StateView: View {

  @State private var count: Int = 0
  @State private var isOn: Bool = false

  var body: some View {
    VStack {
      Toggle(isOn: $isOn) {
        Text("Light")
      }

      Text("\(count)")
        .font(.largeTitle)

      Button {
        count += 1
      } label: {
        Text(isOn ? "On" : "OFF")
      }
    }
    .padding()
  }
}

#Preview {
  StateView()
}
