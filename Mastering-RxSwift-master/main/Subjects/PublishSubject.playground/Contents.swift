//
//  Copyright (c) 2019 KxCoding <kky0317@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import RxSwift


/*:
 # PublishSubject
 */

let disposeBag = DisposeBag()
// 가장기본적인 형태 서브젝트로 이벤트를 옵저버에 전달

enum MyError: Error {
   case error
}
// 비어있는 상태
// 서브젝트는 오브젝트인 동시에 옵저버 이다
//
let subject = PublishSubject<String>()
// 아직 옵저버에 구독하지 않음
subject.onNext("Hello")

// 새로운 옵저보 구독
// 구독이후에 이벤트만 전달
let d1 = subject.subscribe {
  print(">> 1", $0)
}
d1.disposed(by: disposeBag)
subject.onNext("Rxswift")

let d2 = subject.subscribe{
  print(">> 2", $0)
}
d2.disposed(by: disposeBag)
subject.onNext("Subject")

//subject.onCompleted()
subject.onError(MyError.error)
let d3 = subject.subscribe{
  print(">> 3", $0)
}
d2.disposed(by: disposeBag)
subject.onNext("123")
