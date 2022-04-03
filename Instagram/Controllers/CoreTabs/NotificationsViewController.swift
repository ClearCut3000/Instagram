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
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    return tableView
  }()

//MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Notifications"
    view.backgroundColor = .systemBackground
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
  }

  //MARK: - Layout
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }
}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    return cell
  }
}
