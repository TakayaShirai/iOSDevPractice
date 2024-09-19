import Foundation

class SendableViewModel: ObservableObject {
  let manager = CurrentUserManager()

  func updateCurrentUserInfo() async {
    let info = MyUserInfo(name: "USER INFO")

    await manager.updateDatabase(userInfo: info)
  }
}
