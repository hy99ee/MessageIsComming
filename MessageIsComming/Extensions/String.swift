import Foundation
import SwiftyAttributes

extension String {
    func withParagraphStyle(lineHeight: CGFloat? = nil, alignment: NSTextAlignment = .center) -> NSMutableAttributedString {
        self.attributedString.withParagraphStyle(lineHeight: lineHeight, alignment: alignment)
    }
}

extension NSAttributedString {
    func withParagraphStyle(lineHeight: CGFloat? = nil, alignment: NSTextAlignment = .center) -> NSMutableAttributedString {
        let style = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        style.alignment = alignment

        if let lineHeight = lineHeight {
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight
        }

        return self.withParagraphStyle(style)
    }
}
