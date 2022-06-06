import Foundation
import RxCocoa
import RxSwift

struct MessageData {
    let text: [String]
    var options: [MessageOption] = []

    init(text: String, options: [MessageOption] = []) {
        self.text = [text]
        self.options = options
    }

    init(text: [String], options: [MessageOption] = []) {
        self.text = text

        self.options = options
    }
}
