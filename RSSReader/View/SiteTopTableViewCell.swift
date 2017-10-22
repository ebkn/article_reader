//
//  SiteTopTableViewCell.swift
//  RSSReader
//
//  Created by Ebinuma Kenichi on 2017/10/22.
//  Copyright © 2017年 kenichi ebinuma. All rights reserved.
//

import UIKit

class SiteTopTableViewCell: UITableViewCell {
  @IBOutlet weak var siteTopImageView: UIImageView!
  @IBOutlet weak var imageMaskView: UIView!
  @IBOutlet weak var siteNameLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setSiteTopImageView()
    setImageMaskView()
    setSiteNameLabel()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
  
  func setSiteTopImageView() {
    siteTopImageView.contentMode = UIViewContentMode.scaleAspectFill
    siteTopImageView.layer.masksToBounds = true
  }
  
  func setImageMaskView() {
    imageMaskView.alpha = 0.6
  }
  
  func setSiteNameLabel() {
    siteNameLabel.textColor = UIColor.white
    siteNameLabel.textAlignment = NSTextAlignment.center
    siteNameLabel.font = UIFont(name: "Helvetica-Light", size: 40)
  }
}
