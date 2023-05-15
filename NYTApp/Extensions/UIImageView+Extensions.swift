//
//  UIImageView+Extensions.swift
//  NYTApp
//
//  Created by Baki Uçan on 11.05.2023.
//

import UIKit
import SDWebImage

extension UIImageView {

    func setImage(from url: URL?) {
        self.sd_setImage(with: url, placeholderImage: nil, options: .highPriority, completed: nil)
    }
}

