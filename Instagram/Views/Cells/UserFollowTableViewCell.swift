//
//  UserFollowTableViewCell.swift
//  Instagram
//
//  Created by Николай Никитин on 09.04.2022.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
  func didTapFollowUnfollowButton(model: UserRelationship)
}

enum FollowState {
  case followong // indicates the current user is following the other user
  case not_following // indicates the current user is NOT following the other user
}

struct UserRelationship {
  let username: String
  let name: String
  let type: FollowState
}

class UserFollowTableViewCell: UITableViewCell {

//MARK: - Properties
  static let identifier = "UserFollowTableViewCell"
  weak var delegate: UserFollowTableViewCellDelegate?
  private var model: UserRelationship?

  //MARK: - Subview's
  private let profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.masksToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.backgroundColor = .secondarySystemBackground
    return imageView
  }()

  private let nameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.font = .systemFont(ofSize: 17, weight: .semibold)
    return label
  }()

  private let usernameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.font = .systemFont(ofSize: 16, weight: .regular)
    label.textColor = .secondaryLabel
    return label
  }()

  private let followButton: UIButton = {
    let button = UIButton()
    return button
  }()

  //MARK: - Init's
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.clipsToBounds = true
    contentView.addSubview(profileImageView)
    contentView.addSubview(nameLabel)
    contentView.addSubview(usernameLabel)
    contentView.addSubview(followButton)
    selectionStyle = .none
    followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Layout
  override func layoutSubviews() {
    super.layoutSubviews()
    profileImageView.frame              = CGRect(x: 3,
                                                 y: 3,
                                                 width: contentView.height-6,
                                                 height: contentView.height-6)
    profileImageView.layer.cornerRadius = profileImageView.height/2.0
    let buttonWidth                     = contentView.width > 580 ? 220.0 : contentView.width/3
    followButton.frame                  = CGRect(x: contentView.width-5-buttonWidth,
                                                 y: (contentView.height-40)/2,
                                                 width: buttonWidth,
                                                 height: 40)
    let labelHeight                     = contentView.height/2
    nameLabel.frame                     = CGRect(x: profileImageView.right+5,
                                                 y: 0,
                                                 width: contentView.width-8-profileImageView.width-buttonWidth,
                                                 height: labelHeight)
    usernameLabel.frame                 = CGRect(x: profileImageView.right+5,
                                                 y: nameLabel.bottom,
                                                 width: contentView.width-8-profileImageView.width-buttonWidth,
                                                 height: labelHeight)
  }

  //MARK: - Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    profileImageView.image = nil
    nameLabel.text = nil
    usernameLabel.text = nil
    followButton.setTitle(nil, for: .normal)
    followButton.layer.borderWidth = 0
    followButton.backgroundColor = nil
  }

  public func configure(with model: UserRelationship) {
    self.model = model
    nameLabel.text = model.name
    usernameLabel.text = model.username
    switch model.type {
    case .followong:
      followButton.setTitle("Unfollow", for: .normal)
      followButton.setTitleColor(.label, for: .normal)
      followButton.backgroundColor = .systemBackground
      followButton.layer.borderWidth = 1
      followButton.layer.borderColor = UIColor.label.cgColor
    case .not_following:
      followButton.setTitle("Follow", for: .normal)
      followButton.setTitleColor(.white, for: .normal)
      followButton.backgroundColor = .systemBlue
      followButton.layer.borderWidth = 0
    }
  }

  @objc private func didTapFollowButton() {
    guard let model = model else { return }
    delegate?.didTapFollowUnfollowButton(model: model)
  }
}
