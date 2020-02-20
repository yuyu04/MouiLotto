//
//  TotalCustomUIViewController.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/02/20.
//  Copyright © 2020 SungJu. All rights reserved.
//

import Foundation

class CustomNavigationViewController: UIViewController {
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
}
