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
    var disposeBag = DisposeBag()
    
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
    
    func setUpEventView(_ view: UIStackView) {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10

        let label = UILabel()
        label.text = "이벤트"
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(eventLabel)
//        view.insertArrangedSubview(stackView, at: 0)
        view.insertSubview(stackView, at: 0)
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
        let navItem = navigationItem
        let leftImage = #imageLiteral(resourceName: "NavigationLeftButton")
        
        navItem.leftBarButtonItem?.image = leftImage
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sideMenuNavigationController = segue.destination as? SideMenuNavigationController {
            sideMenuNavigationController.settings.menuWidth = min(view.frame.width, view.frame.height) * 0.75
        }
    }
}
