//
//  LeftMenuViewController.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/25.
//  Copyright © 2020 SungJu. All rights reserved.
//

import UIKit
import SideMenu
import RxSwift

class LeftMenuViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
        }
    }
    
    let mainPageViewModel = MainPageViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var selectionMenuTrailingConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSideMenuControllerCache()
        mainPageViewModel.status$
            .asObservable()
            .subscribe(onNext: { [weak self] status in
                if (self?.sideMenuController?.currentCacheIdentifier() == nil && status == .purchase) { return }
                
                self?.sideMenuController?.setContentViewController(with: status.rawValue, animated: false)
            })
            .disposed(by: disposeBag)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let sidemenuBasicConfiguration = SideMenuController.preferences.basic
        let showPlaceTableOnLeft = (sidemenuBasicConfiguration.position == .under) != (sidemenuBasicConfiguration.direction == .right)
        selectionMenuTrailingConstraint.constant = showPlaceTableOnLeft ? SideMenuController.preferences.basic.menuWidth - size.width : 0
        view.layoutIfNeeded()
    }
    
    func setSideMenuControllerCache() {
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "PurchaseHistory")
        }, with: MainPageStatus.history.rawValue)
//        sideMenuController?.cache(viewControllerGenerator: {
//            self.storyboard?.instantiateViewController(withIdentifier: "RandomPay")
//        }, with: "6")
//        
//        sideMenuController?.cache(viewControllerGenerator: {
//            self.storyboard?.instantiateViewController(withIdentifier: "MenualPay")
//        }, with: "7")
    }

}

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        var cell: LeftMenuButtonCell?
        var disableCell: LeftMenuDisableButtonCell?
        
        if row != 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "MenuButtonCell", for: indexPath) as? LeftMenuButtonCell
        } else {
            disableCell = tableView.dequeueReusableCell(withIdentifier: "MenuDisableButtonCell", for: indexPath) as? LeftMenuDisableButtonCell
        }
        
        switch row {
        case 0:
            cell?.buttonText.text = "공지사항"
        case 1:
            cell?.buttonText?.text = "회원정보수정"
        case 2:
            disableCell?.buttonText?.text = "모의로또"
            disableCell?.selectionStyle = .none;
        case 3:
            cell?.buttonText?.text = "구매내역"
        case 4:
            cell?.buttonText?.text = "환전하기"
        case 5:
            cell?.buttonText?.text = "명예의전당"
        default:
            cell?.buttonText?.text = ""
        }
        
        if cell != nil {
            return cell!
        } else {
            return disableCell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        switch row {
        case 0:
            let viewController = self.storyboard!.instantiateViewController(withIdentifier: "NoticeNavigation")
            sideMenuController?.setContentViewController(to: viewController)
        case 3:
            sideMenuController?.setContentViewController(with: "\(row)", animated: false)
        case 4:
            let viewController = self.storyboard!.instantiateViewController(withIdentifier: "RefundNavigation")
            sideMenuController?.setContentViewController(to: viewController)
        case 5:
            let viewController = self.storyboard!.instantiateViewController(withIdentifier: "RankingNavigation")
            sideMenuController?.setContentViewController(to: viewController)
        default:
            break
        }
        
        sideMenuController?.hideMenu()
        
//        sideMenuController?.setContentViewController(with: "\(row)", animated: Preferences.shared.enableTransitionAnimation)
//        sideMenuController?.hideMenu()
//
//        if let identifier = sideMenuController?.currentCacheIdentifier() {
//            print("[Example] View Controller Cache Identifier: \(identifier)")
//        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = indexPath.row
        
        if row == 2 {
            return 44
        } else {
            return 60
        }
    }
}
