import UIKit

// MARK: Animations
extension MessageView {
    func show(on view: UIView) {
        view.addSubview(self)
        self.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(viewModel.inset.top)
            maker.leading.equalTo(view.safeAreaLayoutGuide.snp.leadingMargin).offset(viewModel.inset.left)
            maker.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailingMargin).inset(viewModel.inset.right)
        }

        self.animate(to: .open)
    }

    func hide(animated: Bool = true) {
        guard self.superview != nil, animated else {
            viewModel.close.onNext(())
            return
        }

        self.animate(to: .closed)
        
    }

    private func animate(to state: ViewInteractiveAnimationState) {
        if let animator = self.transitionAnimator, animator.isRunning || animator.state == .active {
            return
        }

        updateView(for: self.currentState)

        self.transitionAnimator = UIViewPropertyAnimator(duration: self.viewModel.animationDuration, dampingRatio: 1)
        self.transitionAnimator.addAnimations { [weak self] in self?.updateView(for: state) }
        self.transitionAnimator.addCompletion { [weak self] in
            guard let self = self, case .end = $0 else { return }

            self.currentState = state
            self.animationCompletion(to: state)
        }
        self.transitionAnimator.startAnimation()
    }

    private func updateView(for state: ViewInteractiveAnimationState) {
        switch state {
        case .open:
            self.containerView.transform = .identity

        case .closed:
            switch viewModel.animation {
            case .slide:
                let frame = (self.superview ?? self).frame
                let translation = -frame.maxX
                self.containerView.transform = CGAffineTransform(translationX: translation, y: 0)
            }
        }

        self.layoutIfNeeded()
    }

    private func animationCompletion(to state: ViewInteractiveAnimationState) {
        switch state {
        case .open where self.viewModel.autoHide:
            self.autoHideTimer?.invalidate()
            let totalSeconds = self.viewModel.autoHideDelay.totalSeconds
            self.autoHideTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(totalSeconds), repeats: false) { [weak self] _ in self?.hide() }

        case .closed:
            self.viewModel.close.onNext(())

        default: break
        }
    }
}
