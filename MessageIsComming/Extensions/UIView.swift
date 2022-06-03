import UIKit
import VisualEffectView
import RxSwift

extension UIView {
    @discardableResult
    func blur(radius: CGFloat, colorTint: UIColor, colorTintAlpha: CGFloat? = nil) -> VisualEffectView {
        let blurView = VisualEffectView()
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.colorTint = colorTint
        blurView.blurRadius = radius

        if let colorTintAlpha = alphaFromValue(colorTintAlpha) {
            blurView.colorTintAlpha = colorTintAlpha
        }

        self.addSubview(blurView)
        blurView.snp.makeConstraints { $0.edges.equalToSuperview() }

        return blurView
    }

    private func alphaFromValue(_ alpha: CGFloat?) -> CGFloat? {
        guard alpha == nil else { return alpha }
        guard #available(iOS 14.0, *) else { return 1 }
        return nil
    }
}
