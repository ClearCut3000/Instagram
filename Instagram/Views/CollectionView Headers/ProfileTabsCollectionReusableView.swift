//
//  ProfileTabsCollectionReusableView.swift
//  Instagram
//
//  Created by Николай Никитин on 05.04.2022.
//

import UIKit

class ProfileTabsCollectionReusableView: UICollectionReusableView {

  //MARK: - Properties
  static let identifier = "ProfileTabsCollectionReusableView"

  //MARK: - init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .orange
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
