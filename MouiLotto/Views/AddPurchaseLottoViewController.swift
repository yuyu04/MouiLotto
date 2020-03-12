//
//  AddPurchaseLottoViewController.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/03/09.
//  Copyright © 2020 SungJu. All rights reserved.
//

import UIKit
import RxSwift

class AddPurchaseLottoViewController: UIViewController {
    let disposeBag = DisposeBag()
    var delegate: MainViewController?
    
    @IBOutlet weak var purchaseLotto: UIButton!
    @IBOutlet weak var close: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        close.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        purchaseLotto.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.showViewController("")
            })
            .disposed(by: disposeBag)
    }
    
    func showViewController(_ viewControllerName: String) {
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: viewControllerName)
        self.dismiss(animated: true) { () -> Void in
            self.delegate?.sideMenuController?.setContentViewController(to: viewController)
        }
    }
    
}
