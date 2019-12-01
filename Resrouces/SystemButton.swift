//
//  SystemButton.swift
//  TestiBeacon
//
//  Created by Ayaz Rahman on 1/12/19.
//  Copyright © 2019 Ayaz Rahman. All rights reserved.
//

import UIKit

class SystemButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.cornerRadius = frame.height / 4
    }

}
