import Foundation
import RxSwift

class Coordinator<ResultType> {
    typealias CoordinationResult = ResultType

    let disposeBag = DisposeBag()

    private let identifier = UUID()
    private var childCoordinators = [UUID: Any]()

    @discardableResult
    func start() -> Observable<ResultType> {
        fatalError("start() has not been implemented")
    }
    
    func back(viewController: UIViewController? = nil, animated: Bool = true, completion: (() -> Void)? = nil) {
        
    }

    @discardableResult
    func coordinate<T>(to coordinator: Coordinator<T>) -> Observable<T> {
        store(coordinator: coordinator)

        return coordinator.start()
            .do(onNext: { [weak self] _ in self?.release(coordinator: coordinator) })
    }

    private func store<T>(coordinator: Coordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }

    private func release<T>(coordinator: Coordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
    }
}

class StoreCoordinator: Coordinator<Void> {
    static let instance = StoreCoordinator()
}
