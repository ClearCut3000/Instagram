//
//  NotificationFollowEventTableViewCell.swift
//  Instagram
//
//  Created by Николай Никитин on 11.04.2022.
//

import UIKit

class NotificationFollowEventTableViewCell: UITableViewCell {

  //MARK: - Properties
  static let identifier = "NotificationFollowEventTableViewCell"

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
  }

  public func configure(with model: String) {

  }

}
