import Foundation
import RxCocoa

enum MessageOption {
    case dynamicText(Driver<String>)
    case dynamicTextDelay(Int?)
    case inset(UIEdgeInsets)
    case offset(UIEdgeInsets)
    case animation(MessageAnimation)
    case animationDuration(TimeInterval)
    case autoHide(Bool)
    case autoHideDelay(TimeInterval)
    case color(UIColor)
    case tintColor(UIColor)
    case font(UIFont)
}
