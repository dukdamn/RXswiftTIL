//
//  ViewModelBindableType.swift
//  RxMemo
//
//  Created by 황정덕 on 2020/06/11.
//  Copyright © 2020 Gitbot. All rights reserved.
//

import UIKit

protocol ViewModelBindableType {
  associatedtype ViewModelType
  
  var viewModel: ViewModelType! { get set }
  func bindViewModel()
}

extension ViewModelBindableType where Self: UIViewController {
  mutating func bind(viewModel: Self.ViewModelType) {
    self.viewModel = viewModel
    loadViewIfNeeded()
    bindViewModel()
  }
}
