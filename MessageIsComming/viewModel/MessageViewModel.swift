import Foundation
import RxCocoa
import RxSwift
import UIKit

protocol ClosableViewModelType {
    var close: AnyObserver<Void> { get }
    var onClose: Observable<Void> { get }
}

protocol MessageViewModelType: ClosableViewModelType {
    var dynamicText: Driver<String>? { get }
    var inset: UIEdgeInsets { get }
    var offset: UIEdgeInsets { get }
    var animation: MessageAnimation { get }
    var animationDuration: TimeInterval { get }
    var animated: Bool { get }
    var autoHide: Bool { get }
    var autoHideDelay: TimeInterval { get }
    var color: UIColor { get }
    var tintColor: UIColor { get }
    var font: UIFont { get }

    var onUpdateText: Driver<String>! { get }
}

class MessageViewModel: MessageViewModelType {
    private(set) var dynamicText: Driver<String>?
    private(set) var inset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
    private(set) var offset = UIEdgeInsets(top: 12, left: 16, bottom: 0, right: 40)
    private(set) var animation: MessageAnimation = .slide
    private(set) var animationDuration: TimeInterval = 0.5
    var animated: Bool { animationDuration > 0 }
    private(set) var autoHide = true
    private(set) var autoHideDelay: TimeInterval = 5
    private(set) var color: UIColor = .black.withAlphaComponent(0.5)
    private(set) var tintColor: UIColor = .white
    private(set) var font: UIFont = .systemFont(ofSize: 15)
    
    private var text: BehaviorRelay<String>! = nil
    var onUpdateText: Driver<String>! = nil

    let close: AnyObserver<Void>
    let onClose: Observable<Void>

    init(data: MessageData) {
        let close = PublishSubject<Void>()
        self.close = close.asObserver()
        self.onClose = close.asObservable()

        data.options.forEach {
            switch $0 {
            case let .dynamicText(dynamicText): self.dynamicText = dynamicText
            case let .inset(inset): self.inset = inset
            case let .offset(offset): self.offset = offset
            case let .animation(animation): self.animation = animation
            case let .animationDuration(duration): self.animationDuration = duration
            case let .autoHide(value): self.autoHide = value
            case let .autoHideDelay(delay): self.autoHideDelay = delay
            case let .color(color): self.color = color
            case let .tintColor(tintColor): self.tintColor = tintColor
            case let .font(font): self.font = font
            }
        }

        self.text = BehaviorRelay(value: data.text)
        self.onUpdateText = self.dynamicText == nil ? self.text.asDriver() : dynamicText!
    }
}
