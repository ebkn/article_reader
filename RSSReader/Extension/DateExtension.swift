//
//  DateExtension.swift
//  RSSReader
//
//  Created by Ebinuma Kenichi on 2017/11/05.
//  Copyright © 2017年 kenichi ebinuma. All rights reserved.
//

import Foundation

extension Date {
  static func convertDateFromString(inputDate: String) -> Date {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
    let date: Date! = inputFormatter.date(from: inputDate)
    
    return date
  }
  
  func convertStringFromDate() -> String {
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "yyy/MM/dd HH:mm"
    let outputDate = outputFormatter.string(from: self)
    
    return outputDate
  }
}
