//
//  HeroDetailViewController.swift
//  DotaHero
//
//  Created by Septian on 9/17/20.
//  Copyright © 2020 Septian. All rights reserved.
//

import UIKit
import Kingfisher

final class HeroDetailViewController: UIViewController {
  
  @IBOutlet weak var heroNameLabel: UILabel!
  @IBOutlet weak var heroImageView: UIImageView!
  @IBOutlet weak var rolesLabel: UILabel!
  @IBOutlet weak var intLabel: UILabel!
  @IBOutlet weak var agiLabel: UILabel!
  @IBOutlet weak var strLabel: UILabel!
  @IBOutlet weak var attackLabel: UILabel!
  @IBOutlet weak var movementSpeedLabel: UILabel!
  @IBOutlet weak var armorLabel: UILabel!
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var viewModel: HeroDetailViewModel
  
  init(_ viewModel: HeroDetailViewModel) {
    self.viewModel = viewModel
    super.init(nibName: String(describing: HeroDetailViewController.self), bundle: .main)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    configureCollectionView()
    configureViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.fetchOtherHeroes()
  }
  
  private func configureCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UINib(nibName: String(describing: HeroCollectionViewCell.self), bundle: .main), forCellWithReuseIdentifier: String(describing: HeroCollectionViewCell.self))
  }
  
  private func configureViews() {
    heroNameLabel.text = viewModel.currentHero.name
    
    if let urlString = viewModel.currentHero.image, let url = URL(string: OpenDotaService.host+urlString) {
      heroImageView.kf.setImage(with: url, placeholder: UIImage(named: "dota_logo"), options: [.backgroundDecode, .transition(.fade(300))])
    }
    
    var arrayString = [String]()
    if let attackType = viewModel.currentHero.attackType {
      arrayString.append(attackType)
    }
    arrayString.append(contentsOf: viewModel.currentHero.roles)
    let rolesString = arrayString.joined(separator: " - ")
    rolesLabel.text = rolesString
    
    intLabel.text = "\(viewModel.currentHero.baseInt) + \(viewModel.currentHero.intGain)"
    strLabel.text = "\(viewModel.currentHero.baseStr) + \(viewModel.currentHero.strGain)"
    agiLabel.text = "\(viewModel.currentHero.baseAgi) + \(viewModel.currentHero.agiGain)"
    
    attackLabel.text = "\(viewModel.currentHero.baseDamageMin) + \(viewModel.currentHero.baseDamageMax)"
    movementSpeedLabel.text = "\(viewModel.currentHero.movementSpeed)"
    armorLabel.text = "\(viewModel.currentHero.baseArmor)"
  }

  @IBAction func backButtonTapped(_ sender: Any) {
    dismiss(animated: true)
  }
  
  private func showHeroDetail(_ index: IndexPath) {
    guard index.item < viewModel.otherHeroList.count else {
      return
    }
    viewModel.currentHero = viewModel.otherHeroList[index.item]
    configureViews()
  }
}

extension HeroDetailViewController: HeroDetailViewModelDelegate {
  
  func fetchOtherHeroSuccess() {
    DispatchQueue.main.async { [weak self] in
      self?.collectionView.reloadData()
    }
    
  }
  
  func fetchHeroFailedWithMessage(_ message: String) {
    DispatchQueue.main.async { [weak self] in
      self?.showError("Failed fetch other hero", message: message)
    }
    
  }
  
}

extension HeroDetailViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.otherHeroList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HeroCollectionViewCell.self), for: indexPath)
    if let heroCell = cell as? HeroCollectionViewCell {
      let item = viewModel.otherHeroList[indexPath.item]
      heroCell.configure(item: item)
    }
    return cell
  }
  
}

extension HeroDetailViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.showHeroDetail(indexPath)
  }
  
}

extension HeroDetailViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = collectionView.bounds.height
    return CGSize(width: 256 * height / 144, height: height)
  }
}
