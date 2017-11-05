//
//  ArticleStocks.swift
//  RSSReader
//
//  Created by Ebinuma Kenichi on 2017/11/05.
//  Copyright © 2017年 kenichi ebinuma. All rights reserved.
//

import UIKit

class ArticleStocks: NSObject {
  static let sharedInstance = ArticleStocks()
  var articles: Array<Article> = []
  
  func add(_ article: Article) {
    articles.insert(article, at: 0)
    saveArticle()
  }
  
  class func convertToDictionary(_ article: Article) -> Dictionary<String, AnyObject> {
    var dic = Dictionary<String, AnyObject>()
    dic["title"] = article.title as AnyObject
    dic["descript"] = article.descript as AnyObject
    dic["date"] = article.date as AnyObject
    dic["link"] = article.link as AnyObject
    
    return dic
  }
  
  class func convertToArticle(_ dic: Dictionary<String, AnyObject>) -> Article {
    let article = Article()
    article.title = dic["title"] as! String
    article.descript = dic["descript"] as! String
    article.date = dic["date"] as! String
    article.link = dic["link"] as! String
    
    return article
  }
  
  func getArticles() {
    let defaults = UserDefaults.standard
    if let myArticles = defaults.object(forKey: "myArticles") as? Array<Dictionary<String, AnyObject>> {
      for dic in myArticles {
        let article = ArticleStocks.convertToArticle(dic)
        articles.append(article)
      }
    }
  }
  
  func saveArticle() {
    var tmpArticles: Array<Dictionary<String, AnyObject>> = []
    for myArticle in articles {
      let dic = ArticleStocks.convertToDictionary(myArticle)
      tmpArticles.append(dic)
    }
    let defaults = UserDefaults.standard
    defaults.set(tmpArticles, forKey: "myArticles")
    defaults.synchronize()
  }
  
  func removeArticle(index: Int) {
    articles.remove(at: index)
    saveArticle()
  }
}
