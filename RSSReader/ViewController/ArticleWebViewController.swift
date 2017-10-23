//
//  ArticleWebViewController.swift
//  RSSReader
//
//  Created by Ebinuma Kenichi on 2017/10/23.
//  Copyright © 2017年 kenichi ebinuma. All rights reserved.
//

import UIKit
import WebKit

class ArticleWebViewController: UIViewController, WKNavigationDelegate {
  let black = UIColor(red: 50.0 / 255, green: 56.0 / 255, blue: 60.0 / 255, alpha: 1.0)
  let wkWebView = WKWebView()
  let backgroundView = UIView()
  let shareView = UIView()
  var article: Article!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    self.navigationController?.navigationBar.barTintColor = black
    self.navigationController?.navigationBar.tintColor = UIColor.white
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: #selector(self.showActionMenu(_:)))
    
    let url = URL(string: article.link)
    let URLReq = URLRequest(url: url!)
    
    self.wkWebView.navigationDelegate = self
    self.wkWebView.frame = self.view.frame
    self.wkWebView.load(URLReq)
    self.view.addSubview(wkWebView)
  }
  
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    self.navigationItem.title = "Loading..."
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    self.navigationItem.title = wkWebView.title
  }
  
  @objc func showActionMenu(_ sender: AnyObject) {
    setBackgroundView()
    setShareView()
    setShareButton(self.view.frame.width/8, tag: 1, imageName: "RSS_images/facebook_icon")
    setShareButton(self.view.frame.width/8 * 3, tag: 2, imageName: "RSS_images/twitter_icon")
    setShareButton(self.view.frame.width/8 * 5, tag: 3, imageName: "RSS_images/safari_icon")
    setShareButton(self.view.frame.width/8 * 7, tag: 4, imageName: "RSS_images/bookmark_icon")
    
    UIView.animate(withDuration: 0.3, animations: {() -> Void in
      self.shareView.frame.origin = CGPoint(x: 0, y: self.view.frame.height - 100)
    })
  }
  
  func setBackgroundView() {
    backgroundView.frame.size = self.view.frame.size
    backgroundView.frame.origin = CGPoint(x: 0, y: 0)
    backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    
    let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBackgroundView(_:)))
    backgroundView.addGestureRecognizer(gesture)
    
    self.view.addSubview(backgroundView)
  }
  
  @objc func tapBackgroundView(_ sender: AnyObject) {
    backgroundView.removeFromSuperview()
  }
  
  func setShareView() {
    shareView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 100)
    shareView.backgroundColor = UIColor.white
    shareView.layer.cornerRadius = 3
    backgroundView.addSubview(shareView)
  }
  
  func setShareButton(_ x: CGFloat, tag: Int, imageName: String) {
    let shareButton = UIButton()
    shareButton.frame.size = CGSize(width: 60, height: 60)
    shareButton.center = CGPoint(x: x, y: 50)
    shareButton.setBackgroundImage(UIImage(named: imageName), for: UIControlState.normal)
    shareButton.layer.cornerRadius = 3
    shareButton.tag = tag
    shareButton.addTarget(self, action: #selector(self.tapButton(_:)), for: UIControlEvents.touchUpInside)
    shareView.addSubview(shareButton)
  }
  
  @objc func tapButton(_ sender: UIButton) {
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
