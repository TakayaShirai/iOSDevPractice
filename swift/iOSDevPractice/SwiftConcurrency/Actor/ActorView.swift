import SwiftUI

// 1. What is the problem that actors are solving? -> Data threads problem. Swift Access Race.
// 2. How was this problem solved prior to actors?
// 3. Actors can solve the problem easily!

struct ActorView: View {

  private enum LocalizedString {
    static let homeTabTitle = String(localized: "Home")
    static let BrowseTabTitle = String(localized: "Browse")
  }
  var body: some View {
    TabView {
      HomeView()
        .tabItem {
          Label(LocalizedString.homeTabTitle, systemImage: "house.fill")
        }

      BrowseView()
        .tabItem {
          Label(LocalizedString.BrowseTabTitle, systemImage: "magnifyingglass")
        }
    }
  }
}

#Preview {
  ActorView()
}
