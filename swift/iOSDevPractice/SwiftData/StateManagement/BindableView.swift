import SwiftData
import SwiftUI

@Observable
class Light {
  var isOn: Bool = false
}

struct Room: View {

  @Bindable var light: Light

  var body: some View {
    Toggle(isOn: $light.isOn) {
      EmptyView()
    }
    .fixedSize()
  }
}

struct BindableView: View {

  @State private var light: Light = Light()

  var body: some View {
    VStack {
      Room(light: light)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(light.isOn ? .yellow : .blue)
  }
}

#Preview {
  BindableView()
}
