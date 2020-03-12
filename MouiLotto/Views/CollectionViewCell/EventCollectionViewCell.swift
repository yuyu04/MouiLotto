//
//  EventCollectionViewCell.swift
//  MouiLotto
//
//  Created by sungju Yun on 2020/03/12.
//  Copyright © 2020 SungJu. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var eventImage: UIImageView!
    
    func setImage(_ image: URL) {
        self.eventImage.setImage(with: image)
    }
}
