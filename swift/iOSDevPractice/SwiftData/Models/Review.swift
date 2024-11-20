import Foundation
import SwiftData

@Model
final class Review {
  var subject: String
  var body: String
  var movie: Movie?

  init(subject: String, body: String) {
    self.subject = subject
    self.body = body
  }
}
