//
//  PostViewController.swift
//  Instagram
//
//  Created by Николай Никитин on 28.03.2022.
//

import UIKit

//States or a rendered cell
enum PostRenderType {
  case header(provider: User)
  case primaryContent(provider: UserPost) //post
  case actions(provider: String) //like, comment, share
  case comments(comments: [PostComment])
}

//Model of rendered post
struct PostRenderViewModel {
  let renderType: PostRenderType
}

class PostViewController: UIViewController {

  //MARK: - Properties
  private let model: UserPost?
  private var renderModels = [PostRenderViewModel]()

//MARK: - Subview's
  private let tableView: UITableView = {
    let tableView = UITableView()
    //Register cells
    tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
    tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
    tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
    tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
    return tableView
  }()

  //MARK: - Init's
  init(model: UserPost?) {
    self.model = model
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

  //MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    tableView.delegate = self
    tableView.dataSource = self
    view.addSubview(tableView)
  }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension PostViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return renderModels.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch renderModels[section].renderType {
    case .actions(_): return 1
    case .comments(let comments): return comments.count > 4 ? 4 : comments.count
    case .primaryContent(_): return 1
    case .header(_): return 1
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = renderModels[indexPath.section]
    switch model.renderType {
    case .actions(let actions):

    case .comments(let comments):

    case .primaryContent(let post):

    case .header(let user):

    }
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
