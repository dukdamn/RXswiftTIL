//
//  CustomTableViewCell.swift
//  RxMemo
//
//  Created by 황정덕 on 2020/07/03.
//  Copyright © 2020 Gitbot. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

  static let identifier = "ProductCell"
    
    let categoryLabel = UILabel().then {
      $0.text = ""
      $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
      $0.textColor = UIColor.gray
    }
    
    let productNameLabel = UILabel().then {
      $0.text = ""
      $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
      $0.textColor = UIColor.black
    }
    
    let summaryLabel = UILabel().then {
      $0.text = ""
      $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
      $0.textColor = UIColor.gray
    }
    
    let priceLable = UILabel().then {
      $0.text = ""
      $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
      $0.textColor = UIColor.red
    }
    

      override func awakeFromNib() {
          super.awakeFromNib()
          // Initialization code
      }

      override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)

          // Configure the view for the selected state
      }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      
    setupUI()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
      addSubview(categoryLabel)
      addSubview(productNameLabel)
      addSubview(summaryLabel)
      addSubview(priceLable)
      setupContstraints()
    }
    
    private func setupContstraints() {
      categoryLabel.snp.makeConstraints {
        $0.top.equalToSuperview().offset(10)
        $0.leading.equalToSuperview().offset(20)
      }
      productNameLabel.snp.makeConstraints {
        $0.top.equalTo(categoryLabel.snp.bottom).offset(10)
        $0.leading.equalTo(categoryLabel)
      }
      summaryLabel.snp.makeConstraints {
        $0.top.equalTo(productNameLabel.snp.bottom).offset(10)
        $0.leading.equalTo(categoryLabel)
      }
      priceLable.snp.makeConstraints {
        $0.top.equalTo(summaryLabel.snp.bottom).offset(20)
        $0.bottom.equalToSuperview().offset(-10)
        $0.trailing.equalToSuperview().offset(-20)
      }
    }
    
  }
