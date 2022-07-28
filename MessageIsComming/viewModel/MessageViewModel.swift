import Foundation
import RxCocoa
import RxSwift
import UIKit

protocol ClosableViewModelType {
    var close: AnyObserver<Void> { get }
    var onClose: Observable<Void> { get }
}

protocol MessageViewModelType: ClosableViewModelType {
    var onUpdateText: Driver<String>! { get }
    var dynamicText: Driver<String>? { get }
    var dynamicTextDelay: DispatchTimeInterval { get }
    var inset: UIEdgeInsets { get }
    var offset: UIEdgeInsets { get }
    var animation: MessageAnimation { get }
    var animationDuration: TimeInterval { get }
    var animated: Bool { get }
    var autoHide: Bool { get }
    var autoHideDelay: DispatchTimeInterval { get }
    var color: UIColor { get }
    var tintColor: UIColor { get }
    var font: UIFont { get }
}

class MessageViewModel: MessageViewModelType {
    private(set) var dynamicText: Driver<String>?
    private(set) var dynamicTextDelay: DispatchTimeInterval = .seconds(1)
    private(set) var inset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
    private(set) var offset = UIEdgeInsets(top: 12, left: 16, bottom: 0, right: 40)
    private(set) var animation: MessageAnimation = .slide
    private(set) var animationDuration: TimeInterval = 0.5
    var animated: Bool { animationDuration > 0 }
    private(set) var autoHide = true
    private(set) var autoHideDelay: DispatchTimeInterval = .seconds(5)
    private(set) var color: UIColor = .black.withAlphaComponent(0.5)
    private(set) var tintColor: UIColor = .white
    private(set) var font: UIFont = .systemFont(ofSize: 18)

    var onUpdateText: Driver<String>!

    private var isFirstMessage = true

    let close: AnyObserver<Void>
    let onClose: Observable<Void>

    init(data: MessageData) {
        let close = PublishSubject<Void>()
        self.close = close.asObserver()
        self.onClose = close.asObservable()

        data.options.forEach {
            switch $0 {
            case let .dynamicText(dynamicText): self.dynamicText = dynamicText
            case let .dynamicTextDelay(dynamicTextDelay): self.dynamicTextDelay = dynamicTextDelay
            case let .inset(inset): self.inset = inset
            case let .offset(offset): self.offset = offset
            case let .animation(animation): self.animation = animation
            case let .animationDuration(duration): self.animationDuration = duration
            case let .autoHide(value): self.autoHide = value
            case let .autoHideDelay(delay): self.autoHideDelay = delay; self.autoHide = false
            case let .color(color): self.color = color
            case let .tintColor(tintColor): self.tintColor = tintColor
            case let .font(font): self.font = font
            }
        }

        
        self.onUpdateText = {
            if data.text.isEmpty && dynamicText != nil {
                return dynamicText
            } else {
                self.autoHideDelay = .seconds(Int(Int64(data.text.count) * dynamicTextDelay.totalSeconds))
                return dynamicTextDriver(data.text)
            }
        }()
    }

    private func dynamicTextDriver(_ text: [String]) -> Driver<String> {
        Observable.from(text)
            .concatMap {
                Observable.empty()
                    .delay(self.dynamicTextDelay, scheduler: MainScheduler.instance)
                .startWith($0)
            }
            .asDriver(onErrorJustReturn: "")
    }

//    private var delayWithoutFirst: DispatchTimeInterval {
//        let seconds: DispatchTimeInterval = {
//            if isFirstMessage {
//                isFirstMessage = false
//                return .seconds(0)
//            } else {
//                return dynamicTextDelay
//            }
//        }()
//
//        return seconds
//    }
}
