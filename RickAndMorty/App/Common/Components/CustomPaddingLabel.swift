//
//  CustomPaddingLabel.swift
//  RickAndMorty
//
//  Created by Артур Байбиков on 23.11.2023.
//

import UIKit

final class CustomPaddingLabel: UILabel {
    var edgeInset: UIEdgeInsets = .zero
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(
            top: edgeInset.top,
            left: edgeInset.left,
            bottom: edgeInset.bottom,
            right: edgeInset.right)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + edgeInset.left + edgeInset.right,
            height: size.height + edgeInset.top + edgeInset.bottom)
    }
}
