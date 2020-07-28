//
//  ViewController.swift
//  RxMemo
//
//  Created by 황정덕 on 2020/06/11.
//  Copyright © 2020 Gitbot. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class ViewController: UIViewController {

  let listTableView = UITableView()
  
  let priceFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.numberStyle = NumberFormatter.Style.currency
    f.locale = Locale(identifier: "Ko_kr")
    return f
  }()
  
//  let bag = DisposeBag()
  let nameObservable = Observable.of(appleProducts.map { $0.name } )
  
  let productObservable = Observable.of(appleProducts)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .red
//    listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "standardCell")
//    nameObservable.bind(to: listTableView.rx.items ) { tableView, row, element in
//      let cell = tableView.dequeueReusableCell(withIdentifier: "standardCell")!
//      cell.textLabel?.text = element
//      return cell
//    }
//    .disposed(by: rx.disposeBag)
    listTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
    
    productObservable.bind(to: listTableView.rx.items(cellIdentifier: CustomTableViewCell.identifier, cellType: CustomTableViewCell.self)) { [weak self] row, element, cell in
      cell.categoryLabel.text = element.category
      cell.priceLable.text = element.name
      cell.summaryLabel.text = element.summary
      cell.priceLable.text = self?.priceFormatter.string(from: NSNumber(value: element.price))
      // Reference Count + 1
    }
    .disposed(by: rx.disposeBag)
    
    Observable.zip(listTableView.rx.modelSelected(Product.self), listTableView.rx.itemSelected)
      .bind {[weak self] (product, indexPath) in
        self?.listTableView.deselectRow(at: indexPath, animated: true)
        print(product.name)
    }
    .disposed(by: rx.disposeBag)
    
    listTableView.rx.setDelegate(self)
      .disposed(by: rx.disposeBag)
    setupUI()
  }
  
  private func setupUI() {
    view.addSubview(listTableView)
    setupContstraints()
  }
  
  private func setupContstraints() {
    listTableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

