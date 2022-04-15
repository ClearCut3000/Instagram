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
  let comments: PostRenderViewModel
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
    return feedRenderModels.count * 4
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let model: HomeFeedRanderViewModel
    if section == 0 {
      model = feedRenderModels[0]
    } else {
      let modelPosition = section % 4 == 0 ? section/4 : ((section - (section % 4))/4)
      model = feedRenderModels[modelPosition]
    }
    let subSection = section % 4
    if subSection == 0 {
      //header
      return 1
    } else if subSection == 1 {
      //post
      return 1
    } else if subSection == 2 {
      //actions
      return 1
    } else if subSection == 3 {
      //comments
      let commentsModel = model.comments
      switch commentsModel.renderType {
      case .comments(let comments): return comments.count > 2 ? 2 : comments.count
      @unknown default: fatalError("Invalid case")
      }
    }
    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model: HomeFeedRanderViewModel
    if indexPath.section == 0 {
      model = feedRenderModels[0]
    } else {
      let modelPosition = indexPath.section % 4 == 0 ? indexPath.section/4 : ((indexPath.section - (indexPath.section % 4))/4)
      model = feedRenderModels[modelPosition]
    }

    let subSection = indexPath.section % 4
    if subSection == 0 {
      //header
      let headerModel = model.header
      switch headerModel.renderType {
      case .header(let user):
        let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier,
                                                 for: indexPath) as! IGFeedPostHeaderTableViewCell
        return cell
      @unknown default: fatalError("Invalid case")
      }
    } else if subSection == 1 {
      //post
      let postModel = model.post
      switch postModel.renderType {
      case .primaryContent(let post):
        let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier,
                                                 for: indexPath) as! IGFeedPostTableViewCell
        return cell
      @unknown default: fatalError("Invalid case")
      }
    } else if subSection == 2 {
      //actions
      let actionModel = model.actions
      switch actionModel.renderType {
      case .actions(let provider):
        let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier,
                                                 for: indexPath) as! IGFeedPostActionsTableViewCell
        return cell
      @unknown default: fatalError("Invalid case")
      }
    } else if subSection == 3 {
      //comments
      let commentModel = model.comments
      switch commentModel.renderType {
      case .comments(let comments):
        let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier,
                                                 for: indexPath) as! IGFeedPostGeneralTableViewCell
        return cell
      @unknown default: fatalError("Invalid case")
      }
    }
    return UITableViewCell()
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let subSection = indexPath.section % 4
    if subSection == 0 {
      return 70
    } else if subSection == 1 {
      return tableView.width
    } else if subSection == 2 {
      return 60
    } else if subSection == 3 {
      return 50
    }
    return 0
  }
}
