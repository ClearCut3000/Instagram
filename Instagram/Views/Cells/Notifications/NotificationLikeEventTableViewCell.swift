//
//  NotificationLikeEventTableViewCell.swift
//  Instagram
//
//  Created by Николай Никитин on 11.04.2022.
//

import SDWebImage
import UIKit

protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
  func didTapFRelatedPostButton(model: UserNotification)
}

class NotificationLikeEventTableViewCell: UITableViewCell {

  //MARK: - Properties
  static let identifier = "NotificationLikeEventTableViewCell"
  weak var delegate: NotificationLikeEventTableViewCellDelegate?
  private var model: UserNotification?

  //MARK: - Subview's
  private let profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .tertiarySystemBackground
    imageView.layer.masksToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()

  private let label: UILabel = {
    let label = UILabel()
    label.textColor = .label
    label.numberOfLines = 0
    label.text = ""
    return label
  }()

  private let postButton: UIButton = {
    let button = UIButton()
    return button
  }()
  
  //MARK: - Init's
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.clipsToBounds = true
    contentView.addSubview(profileImageView)
    contentView.addSubview(label)
    contentView.addSubview(postButton)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Layout
  override func layoutSubviews() {
    super.layoutSubviews()
    profileImageView.frame = CGRect(x: 3,
                                    y: 3,
                                    width: contentView.height-6,
                                    height: contentView.height-6)
    profileImageView.layer.cornerRadius = profileImageView.height/2
    let size = contentView.height-4
    postButton.frame = CGRect(x: contentView.width-5-size, y: 2, width: size, height: size)
    label.frame = CGRect(x: profileImageView.right+5,
                         y: 0,
                         width: contentView.width-size-profileImageView.width-16,
                         height: contentView.height)
  }

  //MARK: - Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    postButton.setBackgroundImage(nil, for: .normal)
    label.text = nil
    profileImageView.image = nil
  }

  public func configure(with model: UserNotification) {
    self.model = model
    switch model.type {
    case .like(let post):
      let thumbnail = post.thumbnailImage
      postButton.sd_setBackgroundImage(with: thumbnail, for: .normal, completed: nil)
    case .follow:
      break
    }
    label.text = model.text
    profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
  }
}
