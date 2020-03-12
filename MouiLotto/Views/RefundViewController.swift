//
//  RefundViewController.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/03/11.
//  Copyright © 2020 SungJu. All rights reserved.
//

import UIKit

class RefundViewController: CustomNavigationViewController {
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var mainView: UIView!
    
    let viewModel = RefundViewModel()
    
    let doRefundView = DoRefundView.instanceFromNib()
    let doNotRefundView = DoNotRefundView.instanceFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setUpEventView(eventView)
        
        viewModel.totalMoney$
            .asObservable()
            .subscribe(onNext: { [weak self] money in
                if (money > 5000) {
                    self?.doRefund()
                } else {
                    self?.doNotRefund()
                }
            })
            .disposed(by: disposeBag)
            
        
        
    }
    
    func doRefund() {
        doNotRefundView.removeFromSuperview()
        mainView.addSubview(doRefundView)
        
        doRefundView.translatesAutoresizingMaskIntoConstraints = false
        doRefundView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0.0).isActive = true
        doRefundView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: 0.0).isActive = true
        doRefundView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0.0).isActive = true
        doRefundView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0.0).isActive = true
    }
    
    func doNotRefund() {
        doRefundView.removeFromSuperview()
        mainView.addSubview(doNotRefundView)
        
        doNotRefundView.translatesAutoresizingMaskIntoConstraints = false
        doNotRefundView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0.0).isActive = true
        doNotRefundView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: 0.0).isActive = true
        doNotRefundView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0.0).isActive = true
        doNotRefundView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0.0).isActive = true
    }
}
