//
//  IGFeedPostHeaderTableViewCell.swift
//  Instagram
//
//  Created by Николай Никитин on 03.04.2022.
//

import UIKit

class IGFeedPostHeaderTableViewCell: UITableViewCell {

  //MARK: - Properties
  static let identifier = "IGFeedPostActionsTableViewCell"

  //MARK: - Init's
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.backgroundColor = .systemBlue
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Layout
  override func layoutSubviews() {
    super.layoutSubviews()
  }

  //MARK: - Methods
  public func configure() {

  }


}
