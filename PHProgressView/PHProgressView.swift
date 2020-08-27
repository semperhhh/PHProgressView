//
//  PHProgressView.swift
//  PHProgressView
//
//  Created by zph on 2020/8/26.
//  Copyright © 2020 张鹏辉. All rights reserved.
//

import UIKit

/// 内部的线条
struct PHProgressLine {
    /// 比例
    var ratio: CGFloat
    /// 颜色
    var color: UIColor
}

class PHProgressView: UIView {
    
    /// 线宽
    var lineWidth: CGFloat?
    /// 动画时间
    var animationDuration: CFTimeInterval?
    /// 动画方式
    var animationTimingFunction: CAMediaTimingFunction?
    
    /// 添加的线条数
    var progressLines: [PHProgressLine] = []
    
    /// 动画组
    var progressGroup: [CABasicAnimation] = []
    
    /// 是否有动画
    private var hasAnimation: Bool = true
    
    /// 添加子线条 总的线条比例ratio不能超过1
    /// - Parameter lines: 子线条
    /// - Parameter hasAnimation: 是否有动画 default is true
    func progressAdd(_ lines: [PHProgressLine], _ isAnimation: Bool = true) {
        
        progressLines = lines
        hasAnimation = isAnimation
    }
    
    override func layoutSubviews() {
        
        self.layer.sublayers?.removeAll()
    
        var start: CGFloat = 0
        var end: CGFloat = 0
        for line in progressLines {
            end = self.bounds.width * line.ratio + start
            let shapeLayer: CAShapeLayer = CAShapeLayer()
            let path = CGMutablePath()
            path.move(to: CGPoint(x: start, y: self.bounds.height / 2))
            path.addLine(to: CGPoint(x: end, y: self.bounds.height / 2))
            shapeLayer.path = path
            shapeLayer.lineWidth = lineWidth ?? self.bounds.height
            shapeLayer.strokeColor = line.color.cgColor
            self.layer.addSublayer(shapeLayer)
            
            start += end

            if hasAnimation {
                
                let basicAnimation = CABasicAnimation()
                basicAnimation.keyPath = "strokeEnd"
                basicAnimation.duration = animationDuration ?? 1.0
                basicAnimation.fromValue = 0.0
                basicAnimation.toValue = 1.0
                basicAnimation.timingFunction = animationTimingFunction
                shapeLayer.add(basicAnimation, forKey: nil)
                progressGroup.append(basicAnimation)
            }
        }
        
        print("layoutSubviews", progressLines.count, "group.count", progressGroup.count)
    }
}
