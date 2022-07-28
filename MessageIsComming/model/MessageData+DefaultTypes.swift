import Foundation
import RxCocoa
import RxSwift

extension MessageData {
    enum TimePosition {
        case pre
        case post
    }

    static func Timer(with timer: DispatchTimeInterval, text: String = String(), completionText: String = "", textPosition: TimePosition = .pre) -> MessageData {
        MessageData(text: text, options: [.dynamicText(timerToDynamicText(timer, completionText: completionText)),
                                          .autoHideDelay(.seconds(Int(timer.totalSeconds + Int64(completionText.isEmpty ? 1 : 3))))])
    }
    
    private static func timerToDynamicText(_ timer: DispatchTimeInterval, completionText: String) -> Driver<String> {
        let initValue = Driver.just(convertSecondsToString(0))
        let valueByTimer = Driver<Int>.interval(.seconds(1))
            .map{ $0 + 1 }
            .map{ timer.totalSeconds >= $0 ? $0 : nil }
            .map{ $0 == nil ? completionText :  convertSecondsToString($0!)}

        return Driver.merge([initValue, valueByTimer]).debug("___")
    }
    
    private static func convertSecondsToString(_ seconds: Int) -> String {
        String("\(seconds / 60):\(seconds % 60)")
    }
}
