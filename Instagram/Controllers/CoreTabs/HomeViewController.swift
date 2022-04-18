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
    createMockModels()
    view.addSubview(tableView)
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
  private func  createMockModels() {
    let user = User(username: "Joe",
                    bio: "",
                    name: (first: "", last: ""),
                    profilePhoto: URL(string: "https://www.google.com")!,
                    birthDate: Date(),
                    gender: .male,
                    counts: UserCount(follewers: 5, following: 5, posts: 5),
                    joinDate: Date())
    let post = UserPost(postIdentifier: "",
                        postType: .photo,
                        thumbnailImage: URL(string: "https://www.google.com")!,
                        postURL: URL(string: "https://www.google.com")!,
                        caption: nil,
                        likeCount: [],
                        comments: [],
                        createdDate: Date(),
                        taggedUsers: [],
                        owner: user)
    var comments = [PostComment]()
    for x in 0..<2 {
      comments.append(PostComment(identifier: "",
                                  username: "",
                                  text: "",
                                  createdDate: Date(),
                                  likes: []))
    }
    for x in 0 ..< 5 {
      let viewModel = HomeFeedRanderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                              post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                                              actions: PostRenderViewModel(renderType: .actions(provider: "")),
                                              comments: PostRenderViewModel(renderType: .comments(comments: comments)))
    }
  }

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
      case .header, .primaryContent, .actions: return 0
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
      switch model.header.renderType {
      case .header(let user):
        let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier,
                                                 for: indexPath) as! IGFeedPostHeaderTableViewCell
        cell.configure(with: user)
        return cell
      case .primaryContent, .actions, .comments: return UITableViewCell()
      }
    } else if subSection == 1 {
      //post
      switch model.post.renderType {
      case .primaryContent(let post):
        let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier,
                                                 for: indexPath) as! IGFeedPostTableViewCell
        cell.configure(with: post)
        return cell
      case .header, .actions, .comments: return UITableViewCell()
      }
    } else if subSection == 2 {
      //actions
      switch model.actions.renderType {
      case .actions(let provider):
        let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier,
                                                 for: indexPath) as! IGFeedPostActionsTableViewCell
        return cell
      case .header, .primaryContent, .comments: return UITableViewCell()
      }
    } else if subSection == 3 {
      //comments
      switch model.comments.renderType {
      case .comments(let comments):
        let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier,
                                                 for: indexPath) as! IGFeedPostGeneralTableViewCell
        return cell
      case .header, .primaryContent, .actions: return UITableViewCell()
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
      //header
      return 70
    } else if subSection == 1 {
      //post
      return tableView.width
    } else if subSection == 2 {
      //actions
      return 60
    } else if subSection == 3 {
      //comment row
      return 50
    }
    return 0
  }

  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    let subSection = section % 4
    return subSection == 3 ? 70 : 0
  }
}
