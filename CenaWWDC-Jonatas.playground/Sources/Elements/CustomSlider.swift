//
//  Slider.swift
//  Cena WWDC
//
//  Created by Jonatas Coutinho de Faria on 04/04/20.
//  Copyright © 2020 Jonatas Coutinho de Faria. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

public class CustomSlider: UISlider{

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / -2))
        
        self.minimumTrackTintColor = .black
        self.maximumTrackTintColor = .black
        self.thumbTintColor = Utils.uiColorCaculate(red: 25, green: 104, blue: 130)
    }
    
    public override func trackRect(forBounds bounds: CGRect) -> CGRect {
      return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: 20))
    }

    public override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
        return super.thumbRect(forBounds: bounds, trackRect: rect, value: value).offsetBy(dx: 0, dy: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
