//
//  NotificationFollowEventTableViewCell.swift
//  Instagram
//
//  Created by Николай Никитин on 11.04.2022.
//

import SDWebImage
import UIKit

protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
  func didTapFollowUnfollowButton(model: UserNotification)
}

class NotificationFollowEventTableViewCell: UITableViewCell {

  //MARK: - Properties
  static let identifier = "NotificationFollowEventTableViewCell"
  weak var delegate: NotificationFollowEventTableViewCellDelegate?
  private var model: UserNotification?

  //MARK: - Subview's
  private let profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.masksToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.backgroundColor = .tertiarySystemBackground
    return imageView
  }()

  private let label: UILabel = {
    let label = UILabel()
    label.textColor = .label
    label.numberOfLines = 0
    label.text = ""
    return label
  }()

  private let followButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 4
    button.layer.masksToBounds = true
    return button
  }()

  //MARK: - Init's
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.clipsToBounds = true
    contentView.addSubview(profileImageView)
    contentView.addSubview(label)
    contentView.addSubview(followButton)
    followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
    configureForFollow()
    selectionStyle = .none
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
    profileImageView.layer.cornerRadius = profileImageView.height/2
    followButton.frame                  = CGRect(x: contentView.width-5-100,
                                                 y: (contentView.height-40)/2,
                                                 width: 100,
                                                 height: 40)
    label.frame                         = CGRect(x: profileImageView.right+5,
                                                 y: 0,
                                                 width: contentView.width-100-profileImageView.width-16,
                                                 height: contentView.height)
  }

  //MARK: - Methods
  @objc private func didTapFollowButton() {
    guard let model = model else { return }
    delegate?.didTapFollowUnfollowButton(model: model)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    followButton.setTitle(nil, for: .normal)
    followButton.backgroundColor = nil
    followButton.layer.borderWidth = 0
    label.text = nil
    profileImageView.image = nil
  }

  private func configureForFollow() {
    followButton.setTitle("Unfollow", for: .normal)
    followButton.setTitleColor(.label, for: .normal)
    followButton.layer.borderWidth = 1
    followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
  }

  public func configure(with model: UserNotification) {
    self.model = model
    switch model.type {
    case .like(_):
      break
    case .follow(let state):
      switch state {
      case .followong:
        configureForFollow()
      case .not_following:
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitleColor(.white, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = .link
      }
      break
    }
    label.text = model.text
    profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
  }
}

