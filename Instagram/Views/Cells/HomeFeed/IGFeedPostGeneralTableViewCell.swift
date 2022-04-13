//
//  IGFeedPostGeneralTableViewCell.swift
//  Instagram
//
//  Created by Николай Никитин on 03.04.2022.
//

import UIKit

///Comments
class IGFeedPostGeneralTableViewCell: UITableViewCell {

  //MARK: - Properties
  static let identifier = "IGFeedPostGeneralTableViewCell"

  //MARK: - Init's
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
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
