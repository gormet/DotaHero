//
//  HeroCollectionViewCell.swift
//  DotaHero
//
//  Created by Septian on 9/16/20.
//  Copyright © 2020 Septian. All rights reserved.
//

import UIKit
import Kingfisher

class HeroCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    imageView.layer.borderWidth = 2
    imageView.layer.borderColor = UIColor.black.cgColor
  }
  
  func configure(item: Hero) {
    nameLabel.text = item.name
    
    guard let urlString = item.image, let url = URL(string: OpenDotaService.host+urlString) else {
      return
    }
    let resizingProcessor = ResizingImageProcessor(referenceSize: CGSize(width: self.imageView.frame.size.width * UIScreen.main.scale, height: self.imageView.frame.size.height * UIScreen.main.scale))

    imageView.kf.setImage(with: url, placeholder: UIImage(named: "dota_logo"), options: [.backgroundDecode,.processor(resizingProcessor)])
  }
}
