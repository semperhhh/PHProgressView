//
//  ViewController.swift
//  PHProgressView
//
//  Created by zph on 2020/8/26.
//  Copyright © 2020 张鹏辉. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var progress: PHProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        progress = PHProgressView()
        progress.layer.cornerRadius = 10
        progress.layer.masksToBounds = true
        progress.backgroundColor = UIColor.red
        progress.animationTimingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        self.view.addSubview(progress)
        
        print("1")
        
        progress.progressAdd([
            PHProgressLine(ratio: 0.3, color: .blue),
            PHProgressLine(ratio: 0.2, color: .green),
            PHProgressLine(ratio: 0.5, color: .yellow)], true)
        
        print("2")

        progress.snp.makeConstraints { (m) in
            m.top.equalTo(50)
            m.left.equalTo(15)
            m.right.equalTo(-15)
            m.height.equalTo(20)
        }
        
        print("3")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        progress.snp.remakeConstraints { (m) in
            m.top.equalTo(100)
            m.left.equalTo(15)
            m.right.equalTo(-15)
            m.height.equalTo(50)
        }
    }
}



