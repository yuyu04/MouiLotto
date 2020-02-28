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

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBarTitleImage()
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
        
        let leftImage = #imageLiteral(resourceName: "NavigationLeftButton")
        let leftButton = UIBarButtonItem(image: leftImage, style: .plain, target: self, action: #selector(sidemenuOpen(sender:)))
        navigationItem.leftBarButtonItem = leftButton
        
    }
    
    @objc func sidemenuOpen(sender: UIBarButtonItem) {
        sideMenuController?.revealMenu()
    }
}
