

import UIKit
import RxSwift
/*:
 # Observables
 */


let beg = DisposeBag()


1233
// #1
Observable<Int>.create { (observer) -> Disposable in
  observer.on(.next(0))
  observer.onNext(1)
  
  observer.onCompleted()
  
  return Disposables.create()
}

// #2
Observable.from([0,1])



Observable<Int>.of(1,2,3,4)
  .subscribe { (check) in
    print(check.event)
}
.disposed(by: beg)



