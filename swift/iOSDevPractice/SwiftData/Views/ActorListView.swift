import SwiftUI

struct ActorListView: View {

  let actors: [Actor]

  var body: some View {
    List(actors) { actor in
      NavigationLink(value: actor) {
        ActorCellView(actor: actor)
          .modelContainer(for: [Movie.self, Actor.self, Review.self])
      }
    }
    .navigationDestination(for: Actor.self) { actor in
      ActorDetailScreen(actor: actor)
        .modelContainer(for: [Actor.self, Movie.self, Review.self])
    }
  }
}

#Preview {
  ActorListView(actors: [])
}
