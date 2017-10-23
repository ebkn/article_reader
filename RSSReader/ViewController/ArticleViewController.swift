//
//  ArticleViewController.swift
//  RSSReader
//
//  Created by Ebinuma Kenichi on 2017/10/19.
//  Copyright © 2017年 kenichi ebinuma. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController, UIScrollViewDelegate, ArticleTableViewDelegate {
  @IBOutlet weak var headerView: UIView!
  @IBOutlet weak var sitesScrollView: UIScrollView!
  
  let wired = "WIRED"
  let shiki = "100SHIKI"
  let cinra = "CINRA.NET"
  
  let wiredURL = "https://wired.jp/rssfeeder/"
  let shikiURL =  "https://www.100shiki.com/feed"
  let cinraURL =   "https://www.cinra.net/feed"
  
  let wiredImageName = "RSS_images/wired_top_image.png"
  let shikiImageName = "RSS_images/100shiki_top_image.png"
  let cinraImageName = "RSS_images/cinra_top_image.png"
  
  let blue = UIColor(red: 92.0 / 255, green: 192.0 / 255, blue: 210.0 / 255, alpha: 1.0)
  let yellow = UIColor(red: 105.0 / 255, green: 207.0 / 255, blue: 153.0 / 255, alpha: 1.0)
  let red = UIColor(red: 195.0 / 255, green: 123.0 / 255, blue: 175.0 / 255, alpha: 1.0)
  let black = UIColor(red: 50.0 / 255, green: 56.0 / 255, blue: 60.0 / 255, alpha: 1.0)
  
  var tabButtons: Array<UIButton> = []
  
  var currentSelectedArticle: Article?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    sitesScrollView.contentSize = CGSize(width: self.view.frame.width * 3, height: self.view.frame.height)
    sitesScrollView.isPagingEnabled = true
    
    setTabButton(self.view.center.x / 2, text: "W", color: blue, tag: 1)
    setTabButton(self.view.center.x, text: "100", color: yellow, tag: 2)
    setTabButton(self.view.center.x * 3 / 2, text: "C", color: red, tag: 3)
    
    setArticleTableView(0, wired, wiredURL, wiredImageName, blue)
    setArticleTableView(self.view.frame.width, shiki, shikiURL, shikiImageName, yellow)
    setArticleTableView(self.view.frame.width * 2, cinra, cinraURL, cinraImageName, red)
    
    sitesScrollView.delegate = self
    
    setSelectedButton(tabButtons[0], true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  func setArticleTableView(_ x: CGFloat, _ siteName: String, _ siteURL: String, _ siteImageName: String, _ color: UIColor) {
    let frame = CGRect(x: x, y: 0, width: self.view.frame.width, height: self.view.frame.height - headerView.frame.height)
    let articleView = ArticleTableView(frame: frame, style: UITableViewStyle.plain)
    articleView.customDelegate = self
    articleView.siteName = siteName
    articleView.loadRSS(siteURL)
    articleView.siteImageName = siteImageName
    articleView.color = color
    sitesScrollView.addSubview(articleView)
  }
  
  func setTabButton(_ x: CGFloat, text: String, color: UIColor, tag: Int) {
    let tabButton = UIButton()
    tabButton.frame.size = CGSize(width: 36, height: 36)
    tabButton.center = CGPoint(x: x, y: 44)
    tabButton.setTitle(text, for: UIControlState.normal)
    tabButton.setTitleColor(UIColor.white, for: UIControlState.normal)
    tabButton.setTitleColor(color, for: UIControlState.selected)
    tabButton.titleLabel?.font = UIFont(name: "HirakakuProN-W6", size: 13)
    tabButton.addTarget(self, action: #selector(self.tapTabButton(_:)), for: UIControlEvents.touchUpInside)
    tabButton.tag = tag
    tabButton.layer.cornerRadius = 18
    tabButton.layer.borderColor = UIColor.white.cgColor
    tabButton.layer.borderWidth = 1
    tabButton.layer.masksToBounds = true
    headerView.addSubview(tabButton)
    tabButtons.append(tabButton)
  }
  
  @objc func tapTabButton(_ sender: UIButton) {
    let x = self.view.frame.width * CGFloat(sender.tag - 1)
    sitesScrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
  }
  
  func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    let page = scrollView.contentOffset.x / scrollView.frame.width
    
    for num in 0..<3 {
      if page == CGFloat(num) {
        setSelectedButton(tabButtons[num], true)
      } else {
        setSelectedButton(tabButtons[num], false)
      }
    }
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let page = scrollView.contentOffset.x / scrollView.frame.width
    
    for num in 0..<3 {
      if page == CGFloat(num) {
        setSelectedButton(tabButtons[num], true)
      } else {
        setSelectedButton(tabButtons[num], false)
      }
    }
  }
  
  func setSelectedButton(_ button: UIButton, _ selected: Bool) {
    button.isSelected = selected
    button.layer.borderColor = button.titleLabel?.textColor.cgColor
  }
  
  func didSelectTableViewCell(article: Article) {
    currentSelectedArticle = article
    self.performSegue(withIdentifier: "ShowToArticleWebViewController", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let articleWebViewController = segue.destination as! ArticleWebViewController
    articleWebViewController.article = currentSelectedArticle
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
