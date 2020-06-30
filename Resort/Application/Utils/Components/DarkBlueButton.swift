//
//  BlueButton.swift
//  BeResponsible
//
//  Created by Luca LG. Gramaglia on 06/05/2020.
//  Copyright © 2020 lucagramaglia. All rights reserved.
//

import UIKit

@IBDesignable
class DarkBlueButton : UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor(named: "darkButton")
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        self.setTitle(self.title(for: .normal)?.uppercased(), for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
    }
    
    override var isEnabled: Bool {
        didSet {
            self.alpha = isEnabled ? 1.0 : 0.5
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.size.width,
                                                        height: CGFloat.greatestFiniteMagnitude)) ?? .zero
        let desiredButtonSize = CGSize(width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right,
                                       height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)
        return desiredButtonSize
    }
}
