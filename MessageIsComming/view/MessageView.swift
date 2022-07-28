import RxCocoa
import RxSwift
import UIKit
import SnapKit
import SwiftyAttributes
import RxGesture

class MessageView: UIView {
    private(set) var viewModel: MessageViewModelType!
    private(set) var disposeBag = DisposeBag()

    private(set) lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 13
        view.blur(radius: 10, colorTint: viewModel.color)

        return view
    }()

    private lazy var messageView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.text = " "

        return view
    }()

    private lazy var closeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true

        return view
    }()

    private lazy var closeIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "CloseButton")?.withTintColor(viewModel.tintColor)
        

        return view
    }()
    private lazy var hide: AnyObserver<Void> = AnyObserver { [weak self] _ in
        guard let self = self else { return }

        self.autoHideTimer?.invalidate()
        self.hide()
    }

    internal var currentState: ViewInteractiveAnimationState = .closed
    internal var transitionAnimator: UIViewPropertyAnimator!
    internal var autoHideTimer: Timer!

    func setup(viewModel: MessageViewModelType) {
        self.disposeBag = DisposeBag()
        self.viewModel = viewModel

        configure()
        setupBindings()
    }

    private func configure() {
        self.addSubview(containerView)
        containerView.snp.makeConstraints { $0.edges.equalToSuperview() }

        containerView.addSubview(messageView)
        messageView.snp.makeConstraints { maker in
            maker.top.bottom.equalToSuperview().inset(viewModel.offset.top)
            maker.leading.equalToSuperview().offset(viewModel.offset.left)
            maker.trailing.equalToSuperview().inset(viewModel.offset.right)
        }

        containerView.addSubview(closeView)
        closeView.snp.makeConstraints { maker in
            maker.top.bottom.trailing.equalToSuperview()
            maker.leading.equalTo(messageView.snp.trailing)
        }

        closeView.addSubview(closeIcon)
        closeIcon.snp.makeConstraints { maker in
            maker.width.height.equalTo(12)
            maker.top.trailing.equalToSuperview().inset(12)
        }
    }
}

// MARK: Bindings
extension MessageView {
    private func setupBindings() {
        self.viewModel.onUpdateText
            .map { [unowned self] text -> NSAttributedString in
                text.withFont(viewModel.font)
                    .withParagraphStyle(lineHeight: viewModel.font.lineHeight, alignment: .left)
                    .withTextColor(self.viewModel.tintColor)
            }
            .drive(self.messageView.rx.attributedText)
            .disposed(by: self.disposeBag)

        self.closeView.rx.tapView()
            .emit(to: hide)
            .disposed(by: self.disposeBag)

        self.rx.swipeGesture(.left)
            .when(.recognized)
            .map({ _ -> Void in })
            .bind(to: hide)
            .disposed(by: disposeBag)
    }
}
