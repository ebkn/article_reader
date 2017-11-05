//
//  MyPageTableViewController.swift
//  RSSReader
//
//  Created by Ebinuma Kenichi on 2017/11/05.
//  Copyright © 2017年 kenichi ebinuma. All rights reserved.
//

import UIKit

class MyPageTableViewController: UITableViewController {
  var articleStocks = ArticleStocks.sharedInstance
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
    self.tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.tableView.reloadData()
    self.navigationItem.leftBarButtonItem = editButtonItem
    self.navigationController?.navigationBar.tintColor = UIColor.white
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 1
    } else {
      return articleStocks.articles.count
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
      let article = articleStocks.articles[indexPath.row]
      cell.title.text = article.title
      cell.descript.text = article.descript
      let date = Date.convertDateFromString(inputDate: article.date)
      cell.date.text = date.convertStringFromDate()
      return cell
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return 200
    } else {
      return 80
    }
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    if indexPath.section == 0 {
      return false
    } else {
      return true
    }
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    switch editingStyle {
    case UITableViewCellEditingStyle.delete:
      articleStocks.removeArticle(index: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    default:
      return
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section != 0 {
      let article = self.articleStocks.articles[indexPath.row]
      self.performSegue(withIdentifier: "ShowToArticleWebViewController", sender: article)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let articleWebViewController = segue.destination as! ArticleWebViewController
    articleWebViewController.article = sender as! Article
  }
}
