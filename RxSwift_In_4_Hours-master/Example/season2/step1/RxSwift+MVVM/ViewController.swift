//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import RxSwift
import SwiftyJSON
import UIKit

// 비동기적으로 생선된 데이터를 리턴값으로 전달 하는거다
// 그 값을 사용할 떄는 나중에 오면 그 메서드를 호출하면 된다

let MEMBER_LIST_URL = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"
// Observable
class 나중에생기는데이터<T> {
  private let task: (@escaping (T) -> Void) -> Void
  
  init(task: @escaping (@escaping (T) -> Void) -> Void) {
    self.task = task
  }
  
  // subscribe
  func 나중에오면(_ f: @escaping (T) -> Void) {
    task(f)
  }
}
class ViewController: UIViewController {
  @IBOutlet var timerLabel: UILabel!
  @IBOutlet var editView: UITextView!
  
  var disposable = DisposeBag()
  override func viewDidLoad() {
    super.viewDidLoad()
    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
      self?.timerLabel.text = "\(Date().timeIntervalSince1970)"
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
  }
  private func setVisibleWithAnimation(_ v: UIView?, _ s: Bool) {
    guard let v = v else { return }
    UIView.animate(withDuration: 0.3, animations: { [weak v] in
      v?.isHidden = !s
      }, completion: { [weak self] _ in
        self?.view.layoutIfNeeded()
    })
  }
  
  // escaping 안쓰면 에러
  // escaping 왜 필요하냐면 값을 전달 받았는데
  // 본체함수 끝나고 나서 나중에 실행되야 할떄 escaping이라고 명시 해여야댐
  //
  // func downloadJson(_ url: String) -> 나중에 생기는 데이터<String?>
  func downloadJson(_ url: String,_ completion: @escaping (String?) -> Void) {
    DispatchQueue.global().async {
      let url = URL(string: MEMBER_LIST_URL)!
      let data = try! Data(contentsOf: url)
      let json = String(data: data, encoding: .utf8)
      DispatchQueue.main.async {
        completion(json)
      }
    }
  }
  
  // PromiseKit
  // Bolt
  // rxswift
  
  // URLSession main스레드에서 처리하지 않음
  func downloadJsonAnther(_ url: String) -> Observable<String> {
    // 1. 비동기로 생기는 데이터를 Observable로 감싸서 리턴하는 방법
    // enutter 데이터를 생성시킨다
    return Observable.create() { emitter in
      // 데이터는 여러개를 전달할수 있다
      let url = URL(string: url)!
      let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
        guard error == nil else {
          emitter.onError(error!)
          return }
        if let dat = data, let json = String(data: dat, encoding: .utf8) {
          emitter.onNext(json)
        }
        emitter.onCompleted()
      }
      task.resume()
      // 취소할떄의 동작
      return Disposables.create() {
        task.cancel()
      }
    }
    //    return Observable.create { f in
    //      DispatchQueue.global().async {
    //        let url = URL(string: url)!
    //        let data = try! Data(contentsOf: url)
    //        let json = String(data: data, encoding: .utf8)
    //        DispatchQueue.main.async {
    //          f.onNext(json)
    //          // 이거 해깔림
    //          f.onCompleted()
    //        }
    //      }
    //      // 버린다, 취소
    //      return Disposables.create()
    //    }
  }
  // 비동기적인 데이터를 어떻게 리턴값으로 만들지 나온 유틸리티
  // MARK: SYNC
  
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  // RxSwift의 경우는 completion으로 전달하는게 아니라 비동기적으로 생긴 데이터를 클로져로 전달하는게 아니라 리턴값으로 전달한다
  
  @IBAction func onLoad() {
    editView.text = ""
    self.setVisibleWithAnimation(self.activityIndicator, true)
    
    
    // 2. Observable로 오는 데이터를 처리하는 방법
    //    let observable = downloadJsonAnther(MEMBER_LIST_URL)
    //
    //    let disposable = observable
    //      .subscribe { (event) in
    //        switch event {
    //        case .next:
    //          break
    //        case .completed:
    //          break
    //        case .error:
    //          break
    //        }
    //    }
    let helloObservable = Observable.just("Hello World")
    let jsonObservable = downloadJsonAnther(MEMBER_LIST_URL)
    Observable.zip(jsonObservable, helloObservable) { $1 + "\n" + $0 }
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { json in
        self.editView.text = json
        self.setVisibleWithAnimation(self.activityIndicator, false)
        
      })
      
      
      //    // 데이터가 전달되는 동안에 어떤 데이터가 전달되는데 찎힌다
//      .observeOn(MainScheduler.instance)  // super : operator
//      .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
//      .debug()
//      .map{ json in json?.count ?? 0}
//      .filter{ $0 > 0}
//      .map{ "\($0)" }
//      .subscribe { event in
//        switch event {
//        // 데이터가 전달 될때
//        case .next(let json):
//          self.editView.text = json
//          self.setVisibleWithAnimation(self.activityIndicator, false)
//
//          // 순한참조 가 생긴다 completed 나 error 에서 처리
//        // 데이타 완전히 전달될떄
//        case .completed:
//          break
//        case .error:
//          break
//        }
//    }
    // 1. 비동기로 생기는 데이터를 Observable로 감싸서 리턴하는 방법
    // 2. Observable로 오는 데이터를 처리하는 방법
  }
}

// 비동기처리는 다른스레드를 사용해서 현재진행하는 작업은 작업대로하고 다른스래드에서 하는 작업을 비동기적으로 처리하고 그결과를 비동기적으로 받아서 처리


//Observable 생명주기
//1. Create
//2. Subscribe
//3. onNext / onError
// ---- 끝 ----
//4. onCompleted / onError
//5. Disposed



// 옵저버블 생성
// 간단하게 사용하기 위해서 슈거를 오퍼래이터라 한다
// 생성하는것도 just, from
// 서브스크럽 onNetxt
// 마블다이어 그램을 이해해야한따!!
//생성


