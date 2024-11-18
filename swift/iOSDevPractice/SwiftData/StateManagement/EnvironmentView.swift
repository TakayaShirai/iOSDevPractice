import SwiftUI

struct LightView: View {
  @Bindable public var light: Light

  var body: some View {
    Toggle(isOn: $light.isOn) {
      EmptyView()
    }
    .fixedSize()
  }
}

struct EnvironmentRoom: View {

  @Environment(Light.self) private var light

  var body: some View {
    LightView(light: light)
  }
}

struct Cabin: View {

  @Environment(Light.self) private var light

  var body: some View {
    Image(systemName: light.isOn ? "lightbulb" : "lightbulb.fill")
      .font(.largeTitle)
  }
}

struct EnvironmentView: View {

  @Environment(Light.self) private var light

  var body: some View {
    VStack {
      EnvironmentRoom()
      Cabin()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(light.isOn ? .yellow : .blue)
  }
}

#Preview {
  EnvironmentView()
    .environment(Light())
}
