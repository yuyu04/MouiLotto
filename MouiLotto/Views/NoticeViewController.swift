//
//  NoticeViewController.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/24.
//  Copyright © 2020 SungJu. All rights reserved.
//

import UIKit
import RxSwift

class NoticeViewController: CustomNavigationViewController {
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = NoticeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        super.setUpEventView(eventView)
        bindTableView()
        
        let noticeTest = NoticeData(type: "이벤트", title: "테스트", date: "2020-06-08", main: "Objective-C의 경험을 가지고 있다면, 클래스 인스턴스의 부분으로서 값과 참조를 저장하는 두 가지 방법을 알 것임. 속성 이외에도, 속성에 값을 저장하여 백업 저장소로서 인스턴스 변수를 사용할 수 있음.Swift는 이러한 개념을 속성 선언 하나로 통합시켰음. Swift 속성은 대응하는 인스턴스 변수와 직접적으로 속성에 접근하는 백업 저장소를 가지지 않음. 혼란을 피하기 위해 속성의 선언을 단순하게 하여 정의함.")
        let noticeTest2 = NoticeData(type: "이벤트2", title: "테스트", date: "2020-06-08", main: "Objective-C의 경험을 가지고 있다면, 클래스 인스턴스의 부분으로서 값과 참조를 저장하는 두 가지 방법을 알 것임. 속성 이외에도, 속성에 값을 저장하여 백업 저장소로서 인스턴스 변수를 사용할 수 있음.Swift는 이러한 개념을 속성 선언 하나로 통합시켰음. Swift 속성은 대응하는 인스턴스 변수와 직접적으로 속성에 접근하는 백업 저장소를 가지지 않음. 혼란을 피하기 위해 속성의 선언을 단순하게 하여 정의함.")
        viewModel.setList(list: [noticeTest, noticeTest2])
    }

    private func bindTableView() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.list$.bind(to: tableView.rx.items(cellIdentifier: "NoticeCell", cellType: NoticeCell.self)) {
            (index: Int, element: NoticeData, cell: NoticeCell) in
            cell.title.text = element.title
            cell.type.text = element.type
            cell.date.text = element.date
            cell.mainText.text = element.main

            cell.layer.masksToBounds = false
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOpacity = 0.23
            cell.layer.shadowRadius = 4
        }.disposed(by: disposeBag)
    }
}


extension NoticeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow, indexPathForSelectedRow == indexPath {
            _ = tableView.delegate?.tableView?(tableView, willDeselectRowAt: indexPath)
            tableView.deselectRow(at: indexPath, animated: false)
            tableView.delegate?.tableView?(tableView, didDeselectRowAt: indexPath)
            return nil
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalSize: CGFloat = 100.0
        
        guard let cell = self.tableView.cellForRow(at: indexPath) as? NoticeCell else { return normalSize }
        
        let padding: CGFloat = 25.0
        if let selectedRows = tableView.indexPathsForSelectedRows, selectedRows.contains(indexPath) {
            cell.scrollImage?.image = #imageLiteral(resourceName: "icon_down")
            cell.mainText.sizeToFit()
            return normalSize + cell.mainText.frame.height + padding
        } else {
            cell.scrollImage?.image = #imageLiteral(resourceName: "icon_up")
            return normalSize
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}
