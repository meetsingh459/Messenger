//
//  UIView+Extension.swift
//  Messenger
//
//  Created by Manmeet Singh on 22/12/24.
//

import UIKit

extension UIView {
    
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    public var height: CGFloat {
        return self.frame.size.height
    }
    
    public func constraintsPinToParent(view: UIView) -> [NSLayoutConstraint] {
        let constraints = [
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        return constraints
    }
            
}
