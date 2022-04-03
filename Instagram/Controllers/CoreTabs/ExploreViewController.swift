//
//  ExploreViewController.swift
//  Instagram
//
//  Created by Николай Никитин on 28.03.2022.
//

import UIKit

class ExploreViewController: UIViewController {

  //MARK: - Subview's
  private let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.backgroundColor = .secondarySystemBackground
    return searchBar
  }()

  private var collectionView: UICollectionView?

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.topItem?.titleView = searchBar
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView?.delegate = self
    collectionView?.dataSource = self
    guard let collectionView = collectionView else { return }
    view.addSubview(collectionView)
  }
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }


}
