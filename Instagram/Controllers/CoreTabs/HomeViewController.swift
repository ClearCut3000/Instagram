//
//  HomeViewController.swift
//  Instagram
//
//  Created by Николай Никитин on 28.03.2022.
//

import FirebaseAuth
import UIKit

struct HomeFeedRanderViewModel {
  let header: PostRenderViewModel
  let post: PostRenderViewModel
  let actions: PostRenderViewModel
  let omments: PostRenderViewModel
}

class HomeViewController: UIViewController {

  //MARK: - Properties
  private var feedRenderModels = [HomeFeedRanderViewModel ]()

  //MARK: - Subview's
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
    tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
    tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
    tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
    return tableView
  }()

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    handleNotAuthenticated()
  }

  //MARK: - Layout
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }

  //MARK: - Methods
  private func handleNotAuthenticated() {
    //Check Auth status
    if Auth.auth().currentUser == nil {
      //Show's log in controller
      let loginVC = LoginViewController()
      loginVC.modalPresentationStyle = .fullScreen
      present(loginVC, animated: true)
    }
  }
}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 0
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
    return cell
  }
}
