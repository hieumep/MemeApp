//
//  MeMeClass.swift
//  TestLayoutBeta1
//
//  Created by Hieu Vo on 12/19/15.
//  Copyright © 2015 Hieu Vo. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var topText = String()
    var bottomText = String()
    var image = UIImage()
    var MemedImage = UIImage()
    
    init(topText: String, bottomText: String, image: UIImage, MemedImage: UIImage){
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.MemedImage = MemedImage
    }
    
}