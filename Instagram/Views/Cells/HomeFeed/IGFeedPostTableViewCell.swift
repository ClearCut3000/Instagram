//
//  IGFeedPostTableViewCell.swift
//  Instagram
//
//  Created by Николай Никитин on 03.04.2022.
//

import UIKit

final class IGFeedPostTableViewCell: UITableViewCell {

  //MARK: - Properties
  static let identifier = "IGFeedPostTableViewCell"

  //MARK: - Init's
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Methods
  public func configure() {

  }

}