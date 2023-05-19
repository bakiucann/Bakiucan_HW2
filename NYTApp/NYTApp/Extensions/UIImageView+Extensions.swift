//
//  UIImageView+Extensions.swift
//  NYTApp
//
//  Created by Baki Uçan on 11.05.2023.
//

import UIKit
import SDWebImage

extension UIImageView {
    private static let activityIndicatorKey = "activityIndicator"

    var activityIndicator: UIActivityIndicatorView {
        if let activityIndicator = objc_getAssociatedObject(self, UIImageView.activityIndicatorKey) as? UIActivityIndicatorView {
            return activityIndicator
        } else {
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.hidesWhenStopped = true
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            addSubview(activityIndicator)
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
            objc_setAssociatedObject(self, UIImageView.activityIndicatorKey, activityIndicator, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return activityIndicator
        }
    }

    /// Sets the image of the image view from the specified URL.
    ///
    /// - Parameter url: The URL of the image.
    func setImage(from url: URL?) {
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: url, placeholderImage: nil, options: .highPriority) { [weak self] (image, error, cacheType, imageURL) in
            self?.sd_imageIndicator = nil
        }
    }
}
