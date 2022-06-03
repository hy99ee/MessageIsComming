//
//  ViewController.swift
//  MessageIsComming
//
//  Created by hy99ee on 03.06.2022.
//

import UIKit
import RxCocoa

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        MessageCoordinator.show(parent: view, data: MessageData(text: "Small",
                                                                options: [.autoHideDelay(2)]))
        MessageCoordinator.show(parent: view, data: MessageData(text: "Middle",
                                                                options: [
                                                                    .color(.cyan),
                                                                    .animationDuration(1.3),
                                                                    .offset(UIEdgeInsets(
                                                                        top: 50,
                                                                        left: 20,
                                                                        bottom: 10,
                                                                        right: 100
                                                                    )),
                                                                    .tintColor(.black),
                                                                    .font(UIFont.systemFont(ofSize: 20, weight: .semibold))
                                                                ]))
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            MessageCoordinator.show(parent: self.view, data: MessageData(text: "Large",
                                                                options: [
                                                                    .color(.brown),
                                                                    .animationDuration(3),
                                                                    .autoHide(false),
                                                                    .offset(UIEdgeInsets(
                                                                        top: 100,
                                                                        left: 50,
                                                                        bottom: 25,
                                                                        right: 150
                                                                    )),
                                                                    .font(UIFont.systemFont(ofSize: 60, weight: .bold))
                                                                ]))
        }
    }


}

