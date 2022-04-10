//
//  ListViewController.swift
//  Instagram
//
//  Created by Николай Никитин on 28.03.2022.
//

import UIKit

class ListViewController: UIViewController {

  //MARK: - Properties
  private let data: [UserRelationship]

  //MARK: - Subview's
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(UserFollowTableViewCell.self, forCellReuseIdentifier: UserFollowTableViewCell.identifier)
    return tableView
  }()

  //MARK: - Init's
  init(data: [UserRelationship]) {
    self.data = data
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Layout
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    view.addSubview(tableView)
    view.backgroundColor = .systemBackground
  }
}

//MARK: -
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: UserFollowTableViewCell.identifier, for: indexPath) as! UserFollowTableViewCell
    cell.configure(with: data[indexPath.row])
    cell.delegate = self
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let model = data[indexPath.row]
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 75
  }
}

//MARK: - UserFollowTableViewCellDelegate
extension ListViewController: UserFollowTableViewCellDelegate {
  func didTapFollowUnfollowButton(model: UserRelationship) {
    switch model.type {
    case .followong:
      //perford Firebase updeta to UNfollow
      break
    case .not_following:
      //perford Firebase updeta to follow
      break
    }
  }


}
