//
//  MainViewController.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/11.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation
import RxSwift

class MainViewController: CustomNavigationViewController {

    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var roundLabel: UILabel!
    
    let eventImageViewModel = EventImageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setUpEventView(eventView)
        
        bindCollectionView()
        eventImageViewModel.setEvents(["http://www.bloter.net/wp-content/uploads/2016/08/13239928_1604199256575494_4289308691415234194_n.jpg", "http://www.bloter.net/wp-content/uploads/2016/08/13239928_1604199256575494_4289308691415234194_n.jpg"])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let selectPayTypeController = segue.destination as? SelectPayTypeViewController {
            selectPayTypeController.delegate = self
        }
    }
    
    func bindCollectionView() {
        collectionView.rx.didScroll
            .withLatestFrom(collectionView.rx.contentOffset)
            .map { Int($0.x / self.view.frame.width) }
            .bind(to: pageControll.rx.currentPage)
            .disposed(by: disposeBag)

        eventImageViewModel.events$
            .asObservable()
            .subscribe(onNext: { [weak self] in
                self?.pageControll.numberOfPages = $0.count
            })
            .disposed(by: disposeBag)
        
        eventImageViewModel.events$.bind(to: collectionView.rx.items(cellIdentifier: "EventCollectionViewCell")) {
            (index: Int, element: String, cell: EventCollectionViewCell) in
            guard let encode = element.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
                let url = NSURL(string: encode) else { return }
            cell.setImage(url as URL)
        }.disposed(by: disposeBag)
        
        eventImageViewModel.currentRound$
            .asObservable()
            .subscribe(onNext: { [weak self] in
                self?.roundLabel.text = "제 \($0) 회"
            })
            .disposed(by: disposeBag)
        
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }
    
    @objc func scrollAutomatically(_ timer1: Timer) {
        
        if let coll  = self.collectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)!  < eventImageViewModel.events$.value.count - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }
                
            }
        }
        
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
