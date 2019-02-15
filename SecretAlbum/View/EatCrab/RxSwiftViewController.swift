//
//  RxSwiftViewController.swift
//  SecretAlbum
//
//  Created by Jash on 2019/2/15.
//  Copyright © 2019 Jash. All rights reserved.
//

import UIKit
import RxSwift

class RxSwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: view.bounds.width/2, height: view.bounds.height/2)
        button.backgroundColor = .red
        view.addSubview(button)
        button.rx.tap
            .subscribe(onNext: {
                print("button Tapped")
            })
            .disposed(by: DisposeBag)
    }
}
