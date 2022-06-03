import Foundation

struct MessageData {
    let text: String
    let options: [MessageOption]

    init(text: String, options: [MessageOption] = []) {
        self.text = text
        self.options = options
    }
}
