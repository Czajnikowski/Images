//
//  UIImage+mock.swift
//  UI
//
//  Created by Maciek on 19/10/2020.
//

import UIKit

extension UIImage {
    static var mocked: UIImage {
        UIImage(named: "0", in: .current, with: nil)!
    }
}
