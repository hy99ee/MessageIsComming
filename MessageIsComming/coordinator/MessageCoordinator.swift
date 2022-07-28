import RxCocoa
import RxSwift
import UIKit

class MessageCoordinator: Coordinator<Void> {
    private let parentView: UIView
    private let data: MessageData
    private static let store: StoreCoordinator = StoreCoordinator()

    public static func show(parent view: UIView, data: MessageData) {
        let coordinator = MessageCoordinator(parent: view, data: data)
        store.coordinate(to: coordinator).subscribe().disposed(by: store.disposeBag)
    }

    init(parent view: UIView, data: MessageData) {
        self.parentView = view
        self.data = data
    }

    convenience init(parent viewController: UIViewController, data: MessageData) {
        self.init(parent: viewController.view, data: data)
    }

    @discardableResult
    override func start() -> Observable<Void> {
        let viewModel = MessageViewModel(data: data)
        let message = MessageView()
        message.setup(viewModel: viewModel)

        let callback = { [weak self] in
            guard let self = self else { return }
            message.show(on: self.parentView)
        }
//        let callback = {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
//                guard let self = self else { return }
//                message.show(on: self.parentView)
//            }
//        }
        if let otherMessage = parentView.subviews
                .compactMap({ $0 as? MessageView })
                .first {
            otherMessage.viewModel.onClose
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { callback() })
                .disposed(by: self.disposeBag)
            otherMessage.hide()
        } else {
            callback()
        }

        return viewModel.onClose
            .take(1)
            .observe(on: MainScheduler.instance)
            .do(onNext: { message.removeFromSuperview() })
    }
}
