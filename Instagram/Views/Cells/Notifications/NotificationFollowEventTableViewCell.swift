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
    return imageView
  }()

  private let label: UILabel = {
    let label = UILabel()
    label.textColor = .label
    label.numberOfLines = 0
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
    contentView.addSubview(label)
    contentView.addSubview(followButton)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Layout
  override func layoutSubviews() {
    super.layoutSubviews()
  }

  //MARK: - Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    followButton.setTitle(nil, for: .normal)
    followButton.backgroundColor = nil
    followButton.layer.borderWidth = 0
    label.text = nil
    profileImageView.image = nil
  }

  public func configure(with model: UserNotification) {
    self.model = model
    switch model.type {
    case .like(let post):
      break
      let thumbnail = post.thumbnailImage
      postButton.sd_setBackgroundImage(with: thumbnail, for: .normal, completed: nil)
    case .follow:
      break
    }
    label.text = model.text
    profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
  }
}

