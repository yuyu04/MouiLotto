//
//  PurchaseHistoryViewController.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/03/02.
//  Copyright © 2020 SungJu. All rights reserved.
//

import UIKit
import DropDown
import RxSwift

class PurchaseHistoryViewController: CustomNavigationViewController {

    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var historyList: UIView!
    @IBOutlet weak var historyListButton: UIButton!
    @IBOutlet weak var winningNumbersView: UIView!
    @IBOutlet weak var scrollView: UIView!
    
    @IBOutlet var winningNumbersBall: [UIView]!
    
    @IBOutlet weak var addPurchaseLottoButton: UIButton!
    
    var lottoScrollView = UIScrollView()
    
    let lottoPaper = LottoPaperView.instanceFromNib()
    
    let historyViewModel = PurchaseHistoryViewModel()
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setUpEventView(eventView)
        self.setUpDropDownMenu()
        self.setUpLottoView()
        
        historyViewModel.winningNumbers$
            .asObservable()
            .subscribe(onNext: { [weak self] list in
                if (list.count == 7) {
                    self?.winningNumbersView.isHidden = false
                    for i in 0...list.count-1 {
                        var image = #imageLiteral(resourceName: "LottoCircle1_1")
                        switch list[i] {
                        case 11...20:
                            image = #imageLiteral(resourceName: "LottoCircle1_2")
                        case 21...30:
                            image = #imageLiteral(resourceName: "LottoCircle1_3")
                        case 31...40:
                            image = #imageLiteral(resourceName: "LottoCircle1_4")
                        case 41...45:
                            image = #imageLiteral(resourceName: "LottoCircle1_5")
                        default:
                            break
                        }
                        
                        let backgroundImage = UIImageView(frame: self?.winningNumbersBall[0].frame ?? CGRect())
                        backgroundImage.image = image
                        let label = UILabel(frame: backgroundImage.frame)
                        label.textAlignment = .center
                        label.text = String(list[i])
                        self?.winningNumbersBall[i].addSubview(backgroundImage)
                        self?.winningNumbersBall[i].addSubview(label)
                    }
                } else {
                    self?.winningNumbersView.isHidden = true
                }
            })
            .disposed(by: disposeBag)
        
        historyViewModel.lottoResult$
            .asObservable()
            .subscribe(onNext: { [weak self] order in
                if order != 0, let vc = self?.storyboard!.instantiateViewController(withIdentifier: "LottoResult") as? LottoResultViewController {
                    vc.modalPresentationStyle = .fullScreen
                    vc.historyViewModel = self?.historyViewModel
                    self?.present(vc, animated: false, completion: nil)
                }
            })
            .disposed(by: disposeBag)
        
//        historyViewModel.setWinningNumbers([5,10,11,31,41,45,25])
//        historyViewModel.setLottoResult(2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.animationLottoPaper()
    }
    
    func animationLottoPaper() {
        UIView.animate(withDuration: 2.0, animations: {
            self.lottoPaper.frame.origin.y += self.lottoPaper.frame.size.height*0.6
        })
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
        
        historyViewModel.history$
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
        
        historyViewModel.setHistory(["2019-01-02", "2020-01-20"])
    }
    
    func setUpLottoView() {
        lottoScrollView.backgroundColor = .gray
        self.scrollView.addSubview(lottoScrollView)
        
        lottoScrollView.translatesAutoresizingMaskIntoConstraints = false
        lottoScrollView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        lottoScrollView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        lottoScrollView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        lottoScrollView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        
        lottoScrollView.addSubview(lottoPaper)
        
        lottoPaper.translatesAutoresizingMaskIntoConstraints = false
        lottoPaper.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20.0).isActive = true
        lottoPaper.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20.0).isActive = true
        lottoPaper.topAnchor.constraint(equalTo: lottoScrollView.topAnchor, constant: 10.0).isActive = true
        
        lottoScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.width*1.338)
        lottoPaper.setUp()
    }
}
