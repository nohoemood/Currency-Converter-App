// SplitAnimatedBorderView.swift by mac 14.09.2026 

import Foundation
import UIKit

final class SplitAnimatedBorderView: UIView {
    private let rightLayer = CAShapeLayer()
    private let leftLayer = CAShapeLayer()
    
    private let cornerRadius: CGFloat
    private let animationDuration: TimeInterval = 0.6
    
    init(cornerRadius: CGFloat, borderColor: UIColor?, lineWidth: CGFloat = 3.0) {
        self.cornerRadius = cornerRadius
        super.init(frame: .zero)
        
        self.isUserInteractionEnabled = false
        
        setupLayer(rightLayer, color: borderColor, lineWidth: lineWidth)
        setupLayer(leftLayer, color: borderColor, lineWidth: lineWidth)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupLayer(_ layer: CAShapeLayer, color: UIColor?, lineWidth: CGFloat) {
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = color?.cgColor
        layer.lineWidth = lineWidth
        layer.strokeEnd = 0
        layer.lineCap = .round
        self.layer.addSublayer(layer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let midX = bounds.midX
        let maxY = bounds.maxY
        let maxX = bounds.maxX
        let rad = cornerRadius
        
        let rightPath = UIBezierPath()
        rightPath.move(to: CGPoint(x: midX, y: maxY))
        rightPath.addLine(to: CGPoint(x: maxX - rad, y: maxY))
        rightPath.addArc(withCenter: CGPoint(x: maxX - rad, y: maxY - rad), radius: rad, startAngle: CGFloat.pi/2, endAngle: 0, clockwise: false)
        rightPath.addLine(to: CGPoint(x: maxX, y: rad))
        rightPath.addArc(withCenter: CGPoint(x: maxX - rad, y: rad), radius: rad, startAngle: 0, endAngle: -CGFloat.pi/2, clockwise: false)
        rightPath.addLine(to: CGPoint(x: midX, y: 0))
        
        rightLayer.path = rightPath.cgPath
        
        let leftPath = UIBezierPath()
        leftPath.move(to: CGPoint(x: midX, y: maxY))
        leftPath.addLine(to: CGPoint(x: rad, y: maxY))
        leftPath.addArc(withCenter: CGPoint(x: rad, y: maxY - rad), radius: rad, startAngle: CGFloat.pi/2, endAngle: CGFloat.pi, clockwise: true)
        leftPath.addLine(to: CGPoint(x: 0, y: rad))
        leftPath.addArc(withCenter: CGPoint(x: rad, y: rad), radius: rad, startAngle: CGFloat.pi, endAngle: -CGFloat.pi/2, clockwise: true)
        leftPath.addLine(to: CGPoint(x: midX, y: 0))
        
        leftLayer.path = leftPath.cgPath
    }
    
    func animate(isFocused: Bool) {
        let targetValue: CGFloat = isFocused ? 1.0 : 0.0
        
        let rightCurrent = rightLayer.presentation()?.strokeEnd ?? rightLayer.strokeEnd
        let leftCurrent = leftLayer.presentation()?.strokeEnd ?? leftLayer.strokeEnd
        
        rightLayer.strokeEnd = targetValue
        leftLayer.strokeEnd = targetValue
        
        let rightAnim = CABasicAnimation(keyPath: "strokeEnd")
        rightAnim.fromValue = rightCurrent
        rightAnim.toValue = targetValue
        rightAnim.duration = animationDuration
        rightAnim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        rightLayer.add(rightAnim, forKey: "strokeAnimation")
        
        let leftAnim = CABasicAnimation(keyPath: "strokeEnd")
        leftAnim.fromValue = leftCurrent
        leftAnim.toValue = targetValue
        leftAnim.duration = animationDuration
        leftAnim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        leftLayer.add(leftAnim, forKey: "strokeAnimation")
    }
}
