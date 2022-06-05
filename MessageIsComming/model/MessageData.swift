import Foundation
import RxCocoa
import RxSwift

struct MessageData {
    let text: String
    var options: [MessageOption]! = nil

    init(text: String, options: [MessageOption] = []) {
        self.text = text
        self.options = options
    }

    init(text: [String], options: [MessageOption] = []) {
        self.text = String()
        
        self.options = options
        self.options.append(.dynamicText(dynamicTextDriver(text)))
    }

    private func dynamicTextDriver(_ text: [String]) -> Driver<String> {

        let driver = Observable.from(text)
            .concatMap { Observable.empty()
                .delay(.milliseconds(dynamicTextDelay(options)), scheduler: MainScheduler.instance)
                .startWith($0)
            }
            .asDriver(onErrorJustReturn: "")
        
        return driver
    }

    private func dynamicTextDelay(_ options: [MessageOption]) -> Int {
        var options = options
        var delay: Int?
        options.forEach { if case let .dynamicTextDelay(_delay) = $0 { delay = _delay } }
        if delay == nil { delay = 500; options.append(.dynamicTextDelay(delay!)) }
        return delay!
    }
}
