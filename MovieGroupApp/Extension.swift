//
//  Extension.swift
//  MovieGroupApp
//
//  Created by 심소영 on 7/2/24.
//

import UIKit

extension UIImageView {
    func imageViewSetting(){
        self.contentMode = .scaleToFill
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
    }
}

extension UILabel {
    func nameLabel(){
        self.textAlignment = .left
        self.textColor = .white
        self.font = .boldSystemFont(ofSize: 16)
    }
}

extension UITextView {
    func overview(){
        self.textColor = .darkGray
        self.backgroundColor = .white.withAlphaComponent(0.8)
        self.isEditable = false
        self.isSelectable = false
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.isScrollEnabled = true
        let textStyle = NSMutableParagraphStyle()
        textStyle.lineSpacing = 2
        textStyle.paragraphSpacing = 10
        textStyle.alignment = .left
        textStyle.lineBreakMode = .byWordWrapping
        let attributedString = NSAttributedString(string: self.text, attributes: [.paragraphStyle: textStyle, .font: UIFont.systemFont(ofSize: 14)])
        self.attributedText = attributedString
    }
}

extension UIButton {
    func overviewButton(){
        self.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        self.tintColor = .black
        self.backgroundColor = .lightGray.withAlphaComponent(0.8)
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
}
