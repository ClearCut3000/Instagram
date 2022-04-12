//
//  NotificationsViewController.swift
//  Instagram
//
//  Created by Николай Никитин on 28.03.2022.
//

import UIKit

enum UserNotificationType {
  case like(post: UserPost)
  case follow
}

struct UserNotification {
  let type: UserNotificationType
  let text: String
  let user: User
}

final class NotificationsViewController: UIViewController {

  //MARK: - Properties
  private var models = [UserNotification]()

  //MARK: - Subview's
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.isHidden = true
    tableView.register(NotificationLikeEventTableViewCell.self,
                       forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
    tableView.register(NotificationFollowEventTableViewCell.self,
                       forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
    return tableView
  }()

  private lazy var noNotificationsView = NoNotificationsView()

  private let spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView(style: .large)
    spinner.hidesWhenStopped = true
    spinner.tintColor = .label
    return spinner
  }()

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchNotifications()
    navigationItem.title = "Notifications"
    view.backgroundColor = .systemBackground
    view.addSubview(spinner)
    spinner.startAnimating()
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
  }

  //MARK: - Layout
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
    spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    spinner.center = view.center
  }

  //MARK: - Methods
  private func fetchNotifications() {

  }

  private func addNoNotificationView() {
    tableView.isHidden = true
    view.addSubview(noNotificationsView)
    noNotificationsView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/4)
    noNotificationsView.center = view.center
  }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = models[indexPath.row]
    switch model.type {
    case .follow:
      let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
      cell.configure(with: model)
      return cell
    case .like(_):
      let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
      cell.configure(with: model)
      return cell
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 52
  }
}
