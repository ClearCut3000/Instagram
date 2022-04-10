//
//  NotificationLikeEventTableViewCell.swift
//  Instagram
//
//  Created by Николай Никитин on 11.04.2022.
//

import UIKit

class NotificationLikeEventTableViewCell: UITableViewCell {

  //MARK: - Properties
  static let identifier = "NotificationLikeEventTableViewCell"
  
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
