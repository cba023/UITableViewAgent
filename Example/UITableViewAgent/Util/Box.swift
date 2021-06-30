//
//  Box.swift
//  TableViewAgent_Example
//
//  Created by bo.chen on 2021/6/10.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

final class Box<T> {
  
  typealias Listener = (T) -> Void
  var listener: Listener?
  
  var value: T {
    didSet{
      listener?(value)
    }
  }
  
  init(_ value: T) {
    self.value = value
  }
  
  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
