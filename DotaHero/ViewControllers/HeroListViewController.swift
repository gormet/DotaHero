//
//  HeroListViewController.swift
//  DotaHero
//
//  Created by Septian on 9/16/20.
//  Copyright © 2020 Septian. All rights reserved.
//

import UIKit

final class HeroListViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  private var viewModel: HeroListViewModel!
  
  init() {
    super.init(nibName: String(describing: HeroListViewController.self), bundle: .main)
  }
  
  required init?(coder: NSCoder) {
    super.init(nibName: String(describing: HeroListViewController.self), bundle: .main)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = HeroListViewModel(delegate: self)
    configureCollectionView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewModel.fetchDataFromLocal()
    viewModel.fetchDataFromAPI()
  }
  
  private func configureCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UINib(nibName: String(describing: HeroCollectionViewCell.self), bundle: .main), forCellWithReuseIdentifier: String(describing: HeroCollectionViewCell.self))
  }
  
  private func showHeroDetail(_ index: IndexPath) {
    guard index.item < viewModel.heroList.count else {
      return
    }
    let selectedHero = viewModel.heroList[index.item]
    let detailViewModel = HeroDetailViewModel(selectedHero)
    let detailVC = HeroDetailViewController(detailViewModel)
    
    self.present(detailVC, animated: true)
  }
}

extension HeroListViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.heroList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HeroCollectionViewCell.self), for: indexPath)
    if let heroCell = cell as? HeroCollectionViewCell {
      let item = viewModel.heroList[indexPath.item]
      heroCell.configure(item: item)
    }
    return cell
  }
  
}

extension HeroListViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.showHeroDetail(indexPath)
  }
  
}

extension HeroListViewController: HeroListViewModelDelegate {
  func fetchHeroSuccess() {
    collectionView.reloadData()
  }
  
  func fetchHeroFailedWithMessage(_ message: String) {
    showError("Failed fetch data", message: message)
  }
}

extension HeroListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let screenWidth = UIScreen.main.bounds.width
    let itemWidth = screenWidth/6 - collectionView.contentInset.left - collectionView.contentInset.right
    return CGSize(width: itemWidth, height: itemWidth*144/256)
  }
}
