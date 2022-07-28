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
        let firstDelay = 5
        let secondDelay = firstDelay + 2
        let thirdDelay = secondDelay + 7
        
        MessageCoordinator.show(parent: view, data: MessageData.Timer(with: .seconds(firstDelay),completionText: "Lets start"))

//        MessageCoordinator.show(parent: view, data: MessageData(text: ["Small", "Smallar", "NExt"],
//                                                                options: [.autoHideDelay(.seconds(5))]))

        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(secondDelay)) {
            MessageCoordinator.show(parent: self.view, data: MessageData(text: ["Bottom1", "Bottom2","Bottom3","Bottom4","Bottom5","Bottom6","Bottom7","Bottom8", "Bottom9", "Ok\nGo next"] ,
                                                                options: [
                                                                    .dynamicTextDelay(.seconds(1)),
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
//                                                                    .autoHide(false),
//                                                                    .autoHideDelay(.seconds()),
                                                                    .font(UIFont.systemFont(ofSize: 40, weight: .heavy))
                                                                    
                                                                ]))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(thirdDelay)) {
                MessageCoordinator.show(parent: self.view, data: MessageData(text: "Center",
                                                                    options: [
                                                                        .color(.blue),
                                                                        .inset(UIEdgeInsets(
                                                                            top: self.view.frame.height / 2 - 100,
                                                                                left: 50,
                                                                                bottom: 50,
                                                                                right: 50
                                                                            )),
//                                                                        .autoHide(true),
                                                                        .tintColor(.orange),
                                                                        .autoHideDelay(.seconds(10)),
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

