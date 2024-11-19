import Foundation

extension String {
  var isEmptyOrWhitespace: Bool {
    self.trimmingCharacters(in: .whitespaces).isEmpty
  }
}
