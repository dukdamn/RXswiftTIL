//
//  MemoStorageType.swift
//  RxMemo
//
//  Created by 황정덕 on 2020/06/11.
//  Copyright © 2020 Gitbot. All rights reserved.
//
import RxSwift
import Foundation
protocol MemoStorageType {
  @discardableResult
  func createMemo(content: String) -> Observable<Memo>
  
  @discardableResult
  func memoList() -> Observable<[Memo]>
  
  @discardableResult
  func update(memo: Memo, content: String) -> Observable<Memo>
  @discardableResult
  func delete(memo: Memo) -> Observable<Memo>
}
