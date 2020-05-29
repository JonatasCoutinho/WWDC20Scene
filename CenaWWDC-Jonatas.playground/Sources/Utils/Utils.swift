//
//  Utils.swift
//  Cena WWDC
//
//  Created by Jonatas Coutinho de Faria on 04/04/20.
//  Copyright © 2020 Jonatas Coutinho de Faria. All rights reserved.
//

import Foundation
import UIKit

public class Utils{
    
    public static func uiColorCaculate(red : Int, green : Int, blue : Int) -> UIColor {
        return UIColor(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
