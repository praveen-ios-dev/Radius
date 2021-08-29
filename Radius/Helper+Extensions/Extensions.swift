//
//  Extensions.swift
//  Radius
//
//  Created by kumar praveen on 28/08/21.
//

import UIKit

extension UIViewController {
    
    func showAlert(_ vc : UIViewController,title : String? = nil ,message : String,actions : [UIAlertAction] = [UIAlertAction(title: Strings.ok, style: .default, handler: nil)]){
        let alert = UIAlertController(title: title.optionalValue, message: message, preferredStyle: .alert)
        for action in actions{
            alert.addAction(action)
        }
        vc.present(alert, animated: true, completion: nil)
    }
}


extension Optional where Wrapped == String {
    var optionalValue: String {
        guard let unwrapped = self else {
            return emptyString
        }
        return unwrapped
    }
}

extension UIView {
    static let loadingViewTag = 7305377166
    func showLoading(style: UIActivityIndicatorView.Style = .medium) {
        var loading = viewWithTag(UIImageView.loadingViewTag) as? UIActivityIndicatorView
            if loading == nil {
                loading = UIActivityIndicatorView(style: style)
            }
            loading?.translatesAutoresizingMaskIntoConstraints = false
            loading!.startAnimating()
            loading!.hidesWhenStopped = true
            loading?.tag = UIView.loadingViewTag
            addSubview(loading!)
          loading?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            loading?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    func stopLoading() {
        let loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
            loading?.stopAnimating()
            loading?.removeFromSuperview()
    }
}
