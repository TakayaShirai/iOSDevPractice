import SwiftData
import SwiftUI

struct AddReviewScreen: View {

  private enum LocalizedString {
    static let subjectText = String(localized: "Subject")
    static let bodyText = String(localized: "Body")
    static let navigationTitle = String(localized: "Add Review")
    static let dismissalButtonText = String(localized: "Cancel")
    static let saveButtonText = String(localized: "Save")
  }

  let movie: Movie

  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var context

  @State private var subject: String = ""
  @State private var description: String = ""

  private var isFormValid: Bool {
    !subject.isEmptyOrWhitespace && !description.isEmptyOrWhitespace
  }

  var body: some View {
    Form {
      newReviewTextFields()
    }
    .navigationTitle(LocalizedString.navigationTitle)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        dismissalButton()
      }

      ToolbarItem(placement: .topBarTrailing) {
        saveReviewButton()
      }
    }
  }

  @ViewBuilder
  private func newReviewTextFields() -> some View {
    TextField(LocalizedString.subjectText, text: $subject)
    TextField(LocalizedString.bodyText, text: $description)
  }

  @ViewBuilder
  private func dismissalButton() -> some View {
    Button {
      dismiss()
    } label: {
      Text(LocalizedString.dismissalButtonText)
    }
  }

  @ViewBuilder
  private func saveReviewButton() -> some View {
    Button {
      let review = Review(subject: subject, body: description)
      review.movie = movie

      context.insert(review)

      do {
        try context.save()
        movie.reviews.append(review)
      } catch {
        print(error.localizedDescription)
      }

      dismiss()

    } label: {
      Text(LocalizedString.saveButtonText)
    }
    .disabled(!isFormValid)
  }
}
