import Foundation

enum Genre: Int, Codable, CaseIterable, Identifiable {

  case action = 1
  case horror
  case kids
  case fiction

  var id: Int {
    rawValue
  }
}

extension Genre {

  private enum LocalizedString {
    static let actionTitle = String(localized: "Action")
    static let horrorTitle = String(localized: "Horror")
    static let kidsTitle = String(localized: "Kids")
    static let fictionTitle = String(localized: "Fiction")
  }

  var title: String {
    switch self {
    case .action:
      return LocalizedString.actionTitle
    case .horror:
      return LocalizedString.horrorTitle
    case .kids:
      return LocalizedString.kidsTitle
    case .fiction:
      return LocalizedString.fictionTitle
    }
  }
}
