//
//  ArticleTableViewCell.swift
//  RSSReader
//
//  Created by Ebinuma Kenichi on 2017/10/22.
//  Copyright © 2017年 kenichi ebinuma. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var descript: UILabel!
  @IBOutlet weak var date: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
    
}
