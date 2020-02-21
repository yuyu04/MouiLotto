//
//  TotalCustomUIViewController.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/20.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation
import SideMenu

class CustomNavigationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBarTitleImage()
    }
    
    func setUpNavigationBarTitleImage() {
        let navController = navigationController!

        let image = #imageLiteral(resourceName: "NavigationTitle")
        let imageView = UIImageView(image: image)

        imageView.contentMode = .scaleAspectFit
        imageView.center = navController.navigationBar.center

        navigationItem.titleView = imageView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sideMenuNavigationController = segue.destination as? SideMenuNavigationController {
            sideMenuNavigationController.settings.menuWidth = 300.0
        }
    }
}
