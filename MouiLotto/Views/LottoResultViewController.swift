//
//  LottoResultViewController.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/03/04.
//  Copyright © 2020 SungJu. All rights reserved.
//

import UIKit
import RxSwift

class LottoResultViewController: UIViewController {
    let disposeBag = DisposeBag()
    var historyViewModel: PurchaseHistoryViewModel!
    
    @IBOutlet weak var orderResultImage: UIImageView!
    @IBOutlet weak var orderResultLabel: UILabel!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.rx.tap
            .bind {
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        historyViewModel.lottoResult$
        .asObservable()
            .subscribe(onNext: { [weak self] order in
                self?.orderResultLabel.text = "\(order)등 당첨"
                switch order {
                case 1:
                    self?.orderResultImage.image = #imageLiteral(resourceName: "lotto_result_1")
                case 2:
                    self?.orderResultImage.image = #imageLiteral(resourceName: "lotto_result_2")
                case 3:
                    self?.orderResultImage.image = #imageLiteral(resourceName: "lotto_result_3")
                case 4:
                    self?.orderResultImage.image = #imageLiteral(resourceName: "lotto_result_4")
                case 5:
                    self?.orderResultImage.image = #imageLiteral(resourceName: "lotto_result_5")
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}
