//
//  NotificationsViewController.swift
//  Instagram
//
//  Created by Николай Никитин on 28.03.2022.
//

import UIKit

class NotificationsViewController: UIViewController {

  //MARK: - Subview's
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.isHidden = true
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    return cell
  }
}
