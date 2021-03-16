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
 # Observables
 */

// Observables 은 event 만 전달
// Observer은 구독자로 Observables을 바라본다
// Observab;es는 onnext, error, completed 를 Emission 한다 Notification

// #1
// a 는 observer가 저장되있다
let a = Observable<Int>.create { (observer) -> Disposable in
  observer.onNext(4)
  
  observer.onCompleted()
  
  return Disposables.create()
}
.take(1)

a.subscribe {
  print("==start==")
  print($0)
  if let elem = $0.element {
    print(elem)
  }
  print("==end==")
}.dispose()
print("------")
a.subscribe(onNext: { elem in
  print(elem)
  
})
print("duck")












// #2

