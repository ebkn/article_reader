//
//  ProfileTableViewCell.swift
//  RSSReader
//
//  Created by Ebinuma Kenichi on 2017/11/05.
//  Copyright © 2017年 kenichi ebinuma. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setBackgroundImage()
    setProfileImage()
    setNameLabel()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
  
  func setBackgroundImage() {
    backgroundImageView.image = UIImage(named: "RSS_images/cover.png")
    backgroundImageView.contentMode = UIViewContentMode.scaleAspectFill
    backgroundImageView.clipsToBounds = true
  }
  
  func setProfileImage() {
    profileImageView.image = UIImage(named: "RSS_images/pug.png")
    profileImageView.contentMode = UIViewContentMode.scaleAspectFill
    profileImageView.clipsToBounds = true
    profileImageView.layer.borderWidth = 1
    profileImageView.layer.borderColor = UIColor.white.cgColor
    profileImageView.layer.cornerRadius = 3
  }
  
  func setNameLabel() {
    nameLabel.text = "Kenichi Ebinuma"
    nameLabel.font = UIFont(name: "HiraKakuProN-W3", size: 33)
    nameLabel.textColor = UIColor.white
  }
}
