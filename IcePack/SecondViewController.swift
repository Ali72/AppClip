//
//  SecondViewController.swift
//  IcePack
//
//  Created by nixzhu on 2017/7/13.
//  Copyright © 2017年 nixWork. All rights reserved.
//

import UIKit
import AppClip

class SecondViewController: UIViewController {

    @IBAction func createAppClip(_ sender: UIButton) {
        AppClip.create(forURLScheme: "icepack://com.nixWork.IcePack/tab2")
    }
}
