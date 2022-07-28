import Foundation

extension DispatchTimeInterval {
    var totalSeconds: Int64 {
        switch self {
        case .nanoseconds(let ns): return Int64(ns) / 1_000_000_000
        case .microseconds(let us): return Int64(us) / 1_000_000
        case .milliseconds(let ms): return Int64(ms) / 1_000
        case .seconds(let s): return Int64(s)
        default: fatalError("infinite nanoseconds")
        }
    }
}
