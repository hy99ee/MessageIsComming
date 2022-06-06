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
        MessageCoordinator.show(parent: view, data: MessageData(text: ["Small", "Smallar", "NExt"],
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            MessageCoordinator.show(parent: self.view, data: MessageData(text: ["Bottom1", "Bottom2","Bottom3","Bottom4","Bottom5","Bottom6","Bottom7","Bottom8"] ,
                                                                options: [
                                                                    .dynamicTextDelay(1000),
                                                                    .color(.red),
                                                                    .inset(UIEdgeInsets(
                                                                        top: self.view.frame.height / 2,
                                                                            left: 10,
                                                                            bottom: 50,
                                                                            right: 10
                                                                        )),
                                                                    
                                                                    .offset(UIEdgeInsets(
                                                                        top: 70,
                                                                        left: 170,
                                                                        bottom: 25,
                                                                        right: 30
                                                                    )),
                                                                    .tintColor(.black),
                                                                    .autoHide(false),
                                                                    .autoHideDelay(8),
                                                                    .font(UIFont.systemFont(ofSize: 40, weight: .heavy))
                                                                    
                                                                ]))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                MessageCoordinator.show(parent: self.view, data: MessageData(text: "Center",
                                                                    options: [
                                                                        .color(.blue),
                                                                        .inset(UIEdgeInsets(
                                                                            top: self.view.frame.height / 2 - 100,
                                                                                left: 50,
                                                                                bottom: 50,
                                                                                right: 50
                                                                            )),
                                                                        .autoHide(true),
                                                                        .tintColor(.orange),
                                                                        .autoHideDelay(10),
                                                                        .offset(UIEdgeInsets(
                                                                            top: 10,
                                                                            left: 20,
                                                                            bottom: 60,
                                                                            right: 30
                                                                        )),
                                                                        .font(UIFont.systemFont(ofSize: 45, weight: .light))
                                                                    ]))
            }
        }
    }
}

