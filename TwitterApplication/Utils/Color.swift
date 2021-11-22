//
//  Color.swift
//  TwitterApplication
//
//  Created by Janus Jordan on 11/21/21.
//

import UIKit

let ACCENT_COLOR = createColor(red: 29, green: 161, blue: 242, alpha: 1)


func createColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
    return UIColor(red: red/255.0, green: green/255.0,  blue: blue/255.0, alpha: alpha)
}
