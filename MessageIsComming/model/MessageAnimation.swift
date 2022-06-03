import Foundation

enum MessageAnimation {
    case slide
}

enum ViewInteractiveAnimationState {
    case closed
    case open
}

extension ViewInteractiveAnimationState {
    var opposite: Self {
        switch self {
        case .open: return .closed
        case .closed: return .open
        }
    }
}
