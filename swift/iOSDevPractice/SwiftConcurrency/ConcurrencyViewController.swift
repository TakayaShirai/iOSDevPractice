import Foundation
import SwiftUI
import UIKit

class ConcurrencyViewController: UIViewController {

  private enum LocalizedString {
    static let doCatchTryThrowsButtonTitle = String(localized: "DoCatchTryThrows")
    static let downloadImagesButtonTitle = String(localized: "Download Images")
    static let asyncAwaitButtonTitle = String(localized: "Async/Await")
    static let taskButtonTitle = String(localized: "Task")
    static let asyncLetButtonTitle = String(localized: "Async Let")
    static let taskGroupButtonTitle = String(localized: "TaskGroup")
    static let continuationsButtonTitle = String(localized: "Continuations")
    static let structClassActorButtonTitle = String(localized: "Struct Class Actor")
    static let actorButtonTitle = String(localized: "Actor Button")
    static let globalActorButtonTitle = String(localized: "Global Actor")
    static let sendableButtonTitle = String(localized: "Sendable")
    static let asyncPublisherButtonTitle = String(localized: "AsyncPublisher")
    static let strongWeakReferencesButtonTitle = String(localized: "Strong & Weak References")
    static let mvvmButtonTitle = String(localized: "MVVM")
  }

  private lazy var doCatchTryThrowsButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.doCatchTryThrowsButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToDoCatchTryThrowsView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var downloadImageButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.downloadImagesButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToDownloadImagesView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var asyncAwaitButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.asyncAwaitButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToAsyncAwaitView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var taskButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.taskButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToTaskView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var asyncLetButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.asyncLetButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToAsyncLetView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var taskGroupButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.taskGroupButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToTaskGroupView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var continuationsButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.continuationsButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToContinuationsView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var structClassActorButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.structClassActorButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToStructClassActorView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var actorButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.actorButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToActorView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var globalActorButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.globalActorButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToGlobalActorView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var sendableButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.sendableButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToSendableView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var asyncPublisherButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.asyncPublisherButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToAsyncPublisherView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var strongWeakReferencesButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.strongWeakReferencesButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(
      self, action: #selector(navigateToStrongWeakReferencesView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var mvvmButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.mvvmButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(
      self, action: #selector(navigateToMVVMView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubViews()
  }

  private func setUpSubViews() {
    view.addSubview(doCatchTryThrowsButton)
    view.addSubview(downloadImageButton)
    view.addSubview(asyncAwaitButton)
    view.addSubview(taskButton)
    view.addSubview(asyncLetButton)
    view.addSubview(taskGroupButton)
    view.addSubview(continuationsButton)
    view.addSubview(structClassActorButton)
    view.addSubview(actorButton)
    view.addSubview(globalActorButton)
    view.addSubview(sendableButton)
    view.addSubview(asyncPublisherButton)
    view.addSubview(strongWeakReferencesButton)
    view.addSubview(mvvmButton)

    view.backgroundColor = .systemBackground

    let layoutGuide = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      doCatchTryThrowsButton.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      doCatchTryThrowsButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      downloadImageButton.topAnchor.constraint(equalTo: doCatchTryThrowsButton.bottomAnchor),
      downloadImageButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      asyncAwaitButton.topAnchor.constraint(equalTo: downloadImageButton.bottomAnchor),
      asyncAwaitButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      taskButton.topAnchor.constraint(equalTo: asyncAwaitButton.bottomAnchor),
      taskButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      asyncLetButton.topAnchor.constraint(equalTo: taskButton.bottomAnchor),
      asyncLetButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      taskGroupButton.topAnchor.constraint(equalTo: asyncLetButton.bottomAnchor),
      taskGroupButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      continuationsButton.topAnchor.constraint(equalTo: taskGroupButton.bottomAnchor),
      continuationsButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      structClassActorButton.topAnchor.constraint(equalTo: continuationsButton.bottomAnchor),
      structClassActorButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      actorButton.topAnchor.constraint(equalTo: structClassActorButton.bottomAnchor),
      actorButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      globalActorButton.topAnchor.constraint(equalTo: actorButton.bottomAnchor),
      globalActorButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      sendableButton.topAnchor.constraint(equalTo: globalActorButton.bottomAnchor),
      sendableButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      asyncPublisherButton.topAnchor.constraint(equalTo: sendableButton.bottomAnchor),
      asyncPublisherButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      strongWeakReferencesButton.topAnchor.constraint(equalTo: asyncPublisherButton.bottomAnchor),
      strongWeakReferencesButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      mvvmButton.topAnchor.constraint(equalTo: strongWeakReferencesButton.bottomAnchor),
      mvvmButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),
    ])
  }

  @objc func navigateToDoCatchTryThrowsView() {
    let hostingController = UIHostingController(rootView: DoCatchTryThrowsView())
    navigationController?.pushViewController(hostingController, animated: true)
  }

  @objc func navigateToDownloadImagesView() {
    let hostingController = UIHostingController(rootView: DownloadImagesWithAsyncView())
    navigationController?.pushViewController(hostingController, animated: true)
  }

  @objc func navigateToAsyncAwaitView() {
    let hostingController = UIHostingController(rootView: AsyncAwaitView())
    navigationController?.pushViewController(hostingController, animated: true)
  }

  @objc func navigateToTaskView() {
    let hostingController = UIHostingController(rootView: TaskHomeView())
    navigationController?.pushViewController(hostingController, animated: true)
  }

  @objc func navigateToAsyncLetView() {
    let hostingController = UIHostingController(rootView: AsyncLetView())
    navigationController?.pushViewController(hostingController, animated: true)
  }

  @objc func navigateToTaskGroupView() {
    let hostingController = UIHostingController(rootView: TaskGroupView())
    navigationController?.pushViewController(hostingController, animated: true)
  }

  @objc func navigateToContinuationsView() {
    let hostingController = UIHostingController(rootView: ContinuationsView())
    navigationController?.pushViewController(hostingController, animated: true)
  }

  @objc func navigateToStructClassActorView() {
    let hostingController = UIHostingController(rootView: StructClassActorView())
    navigationController?.pushViewController(hostingController, animated: true)
  }

  @objc func navigateToActorView() {
    let hostingController = UIHostingController(rootView: ActorView())
    navigationController?.pushViewController(hostingController, animated: true)
  }

  @objc func navigateToGlobalActorView() {
    let hostingController = UIHostingController(rootView: GlobalActorView())
    navigationController?.pushViewController(hostingController, animated: true)
  }

  @objc func navigateToSendableView() {
    let hostingController = UIHostingController(rootView: SendableView())
    navigationController?.pushViewController(hostingController, animated: true)
  }

  @objc func navigateToAsyncPublisherView() {
    let hostingController = UIHostingController(rootView: AsyncPublisherView())
    navigationController?.pushViewController(hostingController, animated: true)
  }

  @objc func navigateToStrongWeakReferencesView() {
    let hostingController = UIHostingController(rootView: StrongWeakReferencesView())
    navigationController?.pushViewController(hostingController, animated: true)
  }

  @objc func navigateToMVVMView() {
    let hostingController = UIHostingController(rootView: MVVMView())
    navigationController?.pushViewController(hostingController, animated: true)
  }
}
