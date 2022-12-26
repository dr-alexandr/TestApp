//
//  UIViewControllerExtension.swift
//  TestFive
//
//  Created by Dr.Alexandr on 26.12.2022.
//

import UIKit

// MARK: - Presentable
extension UIViewController: Presentable {
    func toPresent() -> UIViewController? {
        return self
    }
}
// MARK: - UILabel
extension UILabel {
    static func getDefaultLabel(font: UIFont = .boldSystemFont(ofSize: 16), text: String = "") -> UILabel {
        let label = UILabel()
        label.font = font
        label.textAlignment = .left
        label.text = text
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }
}
