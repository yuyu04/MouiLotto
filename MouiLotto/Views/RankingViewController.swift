//
//  RankingViewController.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/03/11.
//  Copyright © 2020 SungJu. All rights reserved.
//

import UIKit
import DropDown

class RankingViewController: CustomNavigationViewController {
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var historyListButton: UIButton!
    
    let viewModel = RankingViewModel()
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setUpEventView(eventView)
        
        setUpDropDownMenu()
        bindTableView()
        
        let rankingTest = RankingData(order: 1, icon: "adjustment_case2_balance", name: "김정수", totalMoney: "100,000", totalOrder: [1,0,0,0,4])
        let rankingTest2 = RankingData(order: 2, icon: "adjustment_case2_balance", name: "김정수", totalMoney: "200,000", totalOrder: [1,0,0,0,4])
        viewModel.setList([rankingTest, rankingTest2])
    }
    
    func setUpDropDownMenu() {
        dropDown.backgroundColor = UIColor(rgb: 0x2459A3)
        dropDown.selectionBackgroundColor = UIColor(rgb: 0x2255A1)
        dropDown.textColor = .white
        dropDown.selectedTextColor = .gray
        
        dropDown.anchorView = historyListButton
        dropDown.bottomOffset = CGPoint(x: 0, y: historyListButton.bounds.height)
        
        dropDown.selectionAction = { [weak self] (index, item) in
            self?.historyListButton.setTitle(item, for: .normal)
        }
        
        viewModel.history$
            .asObservable()
            .subscribe(onNext: { [weak self] list in
                if (list.count == 0) {
                    return
                }
                
                self?.dropDown.dataSource = list
                self?.historyListButton.setTitle(list[0], for: .normal)
                self?.dropDown.reloadAllComponents()
            })
            .disposed(by: disposeBag)
        
        historyListButton.rx.tap
            .bind {
                self.dropDown.show()
            }
            .disposed(by: disposeBag)
        
        viewModel.setHistory(["2019-01-02", "2020-01-20"])
    }
    
    private func bindTableView() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.list$.bind(to: tableView.rx.items(cellIdentifier: "RankingCell", cellType: RankingCell.self)) {
            (index: Int, element: RankingData, cell: RankingCell) in
            cell.order.text = String(element.order)
            cell.icon.image = UIImage(named: element.icon)
            cell.name.text = element.name
            cell.totalMoney.text = element.totalMoney
            
            if (element.totalOrder.count == 5) {
                cell.ranking.text = "1등:(\(element.totalOrder[0])) 2등:(\(element.totalOrder[1])) 3등:(\(element.totalOrder[2])) 4등:(\(element.totalOrder[3])) 5등(\(element.totalOrder[4]))"
            } else {
                cell.ranking.text = "1등:(0) 2등:(0) 3등:(0) 4등:(0) 5등(0)"
            }

            cell.layer.masksToBounds = false
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOpacity = 0.23
            cell.layer.shadowRadius = 4
        }.disposed(by: disposeBag)
    }
}

extension RankingViewController: UITableViewDelegate {

//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow, indexPathForSelectedRow == indexPath {
//            _ = tableView.delegate?.tableView?(tableView, willDeselectRowAt: indexPath)
//            tableView.deselectRow(at: indexPath, animated: false)
//            tableView.delegate?.tableView?(tableView, didDeselectRowAt: indexPath)
//            return nil
//        }
//        return indexPath
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.beginUpdates()
//        tableView.endUpdates()
//    }
//
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        tableView.beginUpdates()
//        tableView.endUpdates()
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let normalSize: CGFloat = 100.0
//
//        guard let cell = self.tableView.cellForRow(at: indexPath) as? NoticeCell else { return normalSize }
//
//        let padding: CGFloat = 25.0
//        if let selectedRows = tableView.indexPathsForSelectedRows, selectedRows.contains(indexPath) {
//            cell.scrollImage?.image = #imageLiteral(resourceName: "icon_down")
//            cell.mainText.sizeToFit()
//            return normalSize + cell.mainText.frame.height + padding
//        } else {
//            cell.scrollImage?.image = #imageLiteral(resourceName: "icon_up")
//            return normalSize
//        }
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}
