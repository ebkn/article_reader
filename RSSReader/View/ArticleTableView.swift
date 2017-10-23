//
//  ArticleTableView.swift
//  RSSReader
//
//  Created by Ebinuma Kenichi on 2017/10/19.
//  Copyright © 2017年 kenichi ebinuma. All rights reserved.
//

import UIKit

@objc protocol ArticleTableViewDelegate {
  func didSelectTableViewCell(article: Article)
}

class ArticleTableView: UITableView, UITableViewDelegate, UITableViewDataSource, XMLParserDelegate {
  weak var customDelegate: ArticleTableViewDelegate?
  var siteName: String!
  var siteImageName: String!
  var color: UIColor!
  var elementName: String?
  var articles: Array<Article> = []
  
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
      return self.articles.count
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
      let article = self.articles[indexPath.row]
      print(article.title)
      cell.title.text = article.title
      cell.descript.text = article.descript
      cell.date.text = conversionDateFormat(article.date)
      
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return 200
    } else {
      return 100
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section != 0 {
      let article = articles[indexPath.row]
      self.customDelegate?.didSelectTableViewCell(article: article)
    }
  }
  
  func loadRSS(_ siteURL: String) {
    if let url = URL(string: siteURL) {
      let request = URLRequest(url: url)
      let session = URLSession.shared
      let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
        let parser = XMLParser(data: data!)
        parser.delegate = self
        parser.parse()
      })
      task.resume()
    }
  }
  
  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    self.elementName = elementName
    if self.elementName == "item" {
      let article = Article()
      self.articles.append(article)
    }
  }
  
  func parser(_ parser: XMLParser, foundCharacters string: String) {
    let lastArticle = self.articles.last
    
    if self.elementName == "title" {
      lastArticle?.title += string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    } else if self.elementName == "description" {
      lastArticle?.descript += string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    } else if self.elementName == "pubDate" {
      lastArticle?.date += string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    } else if self.elementName == "link" {
      lastArticle?.link += string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
  }
  
  func parserDidEndDocument(_ parser: XMLParser) {
    let queue = DispatchQueue.main
    queue.sync {
      self.reloadData()
    }
  }
  
  func conversionDateFormat(_ dateString: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
    let date: Date! = inputFormatter.date(from: dateString)
    
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "yyy/MM/dd HH:mm"
    
    return outputFormatter.string(from: date)
  }
}

