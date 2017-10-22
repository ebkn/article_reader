//
//  ArticleTableView.swift
//  RSSReader
//
//  Created by Ebinuma Kenichi on 2017/10/19.
//  Copyright © 2017年 kenichi ebinuma. All rights reserved.
//

import UIKit

class ArticleTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
  var siteName: String!
  var siteImageName: String!
  var color: UIColor!
  
  override init(frame: CGRect, style: UITableViewStyle) {
    super.init(frame: frame, style: style)
    
    self.delegate = self
    self.dataSource = self
    
    self.register(UINib(nibName: "SiteTopTableViewCell", bundle: nil), forCellReuseIdentifier: "SiteTopTableViewCell")
    self.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    } else {
      return 10
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "SiteTopTableViewCell", for: indexPath) as! SiteTopTableViewCell
      cell.siteTopImageView.image = UIImage(named: siteImageName)
      cell.imageMaskView.backgroundColor = color
      cell.siteNameLabel.text = siteName
      
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
      
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return 200
    } else {
      return 50
    }
  }
}

