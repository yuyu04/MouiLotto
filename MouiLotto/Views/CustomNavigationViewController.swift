//
//  TotalCustomUIViewController.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/20.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation
import SideMenu
import RxSwift

class CustomNavigationViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var eventViewModel: EventViewModel? = nil
    let eventLabel = UILabel()
    
    var moneyView = UIView()
    var moneyLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBarTitleImage()
        setUpCheckTotalMoney()
        setUpNavigationBarButton()
    }

    func setUpViewModel(_ eventViewModel: EventViewModel) {
        self.eventViewModel = eventViewModel
        self.eventViewModel!.event$
            .map( {$0} )
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { eventText in
                self.eventLabel.text = eventText
            })
            .disposed(by: self.disposeBag)
    }
    
    func setUpEventView(_ eventView: UIView) {
        let label = UILabel()
        label.text = "이벤트"
        label.textAlignment = .center
        
        eventLabel.text = "AAA"
        eventLabel.textAlignment = .center
        
        let stackView = UIStackView(arrangedSubviews: [label, eventLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.autoresizesSubviews = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(eventLabel)
        
        eventView.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: eventView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: eventView.trailingAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: eventView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: eventView.centerYAnchor).isActive = true
        
        eventLabel.widthAnchor.constraint(equalTo: eventView.widthAnchor, multiplier: 0.8).isActive = true
        eventLabel.widthAnchor.constraint(equalTo: eventView.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setUpNavigationBarTitleImage() {
        let navController = navigationController!

        let image = #imageLiteral(resourceName: "NavigationTitle")
        let imageView = UIImageView(image: image)

        imageView.contentMode = .scaleAspectFit
        imageView.center = navController.navigationBar.center

        navigationItem.titleView = imageView
    }
    
    func setUpNavigationBarButton() {
        navigationItem.leftBarButtonItem = nil;
        navigationItem.hidesBackButton = true
        
        let leftImage = #imageLiteral(resourceName: "NavigationLeftButton").withRenderingMode(.alwaysOriginal)
        let leftButton = UIBarButtonItem(image: leftImage, style: .plain, target: self, action: #selector(sideMenuOpen(sender:)))
        navigationItem.leftBarButtonItem = leftButton
        
        let rightImage = #imageLiteral(resourceName: "adjustment_case2_balance").withRenderingMode(.alwaysOriginal)
        let rightButton = UIBarButtonItem(image: rightImage, style: .plain, target: self, action: #selector(checkCurrentTotalMoney(sender:)))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    func setUpCheckTotalMoney() {
        let imageView = UIImageView(image: UIImage(named: "adjustment_case2_goldbar")! )
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        moneyView.addSubview(imageView)
        moneyView.addSubview(moneyLabel)
        
        imageView.leadingAnchor.constraint(equalTo: moneyView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: moneyView.trailingAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: moneyView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: moneyView.centerYAnchor).isActive = true
        
        moneyLabel.text = "10000"
        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        moneyLabel.centerXAnchor.constraint(equalTo: moneyView.centerXAnchor).isActive = true
        moneyLabel.centerYAnchor.constraint(equalTo: moneyView.centerYAnchor).isActive = true
        moneyLabel.widthAnchor.constraint(equalTo: moneyView.widthAnchor).isActive = true
        moneyLabel.textAlignment = .center
        
        moneyView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(moneyView)
        
        moneyView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        moneyView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70).isActive = true
        moneyView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.25).isActive = true
        moneyView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        
        moneyView.isHidden = true
    }
    
    @objc func sideMenuOpen(sender: UIBarButtonItem) {
        sideMenuController?.revealMenu()
    }
    
    @objc func checkCurrentTotalMoney(sender: UIBarButtonItem) {
        moneyView.isHidden = !moneyView.isHidden
    }
}
