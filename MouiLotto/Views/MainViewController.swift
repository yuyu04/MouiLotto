//
//  MainViewController.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/11.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation
import SideMenu

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBarTitleImage()
    }
    
    func setUpNavigationBarTitleImage() {
        let navController = navigationController!

        let image = #imageLiteral(resourceName: "NavigationTitle")
        let imageView = UIImageView(image: image)

        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height

        imageView.frame = CGRect(x: 0, y: 0, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        imageView.center = navController.navigationBar.center

        navigationItem.titleView = imageView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sideMenuNavigationController = segue.destination as? SideMenuNavigationController else { return }
        sideMenuNavigationController.settings.menuWidth = 300.0
    }


}
