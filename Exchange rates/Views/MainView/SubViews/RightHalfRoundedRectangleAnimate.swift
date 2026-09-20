// RightHalfRoundedRectangleAnimate.swift by mac 10.09.2026 

import Foundation
import SwiftUI

struct RightHalfRoundedRectangleAnimate: Shape {
    var cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        let r = cornerRadius
        
        path.move(to: CGPoint(x: w / 2, y: h))
        
        path.addLine(to: CGPoint(x: w - r, y: h))
        
        path.addArc(center: CGPoint(x: w - r, y: h - r),
                    radius: r,
                    startAngle: .degrees(90),
                    endAngle: .degrees(0),
                    clockwise: true)
        
        path.addLine(to: CGPoint(x: w, y: r))
        
        path.addArc(center: CGPoint(x: w - r, y: r),
                    radius: r,
                    startAngle: .degrees(0),
                    endAngle: .degrees(-90),
                    clockwise: true)
        
        path.addLine(to: CGPoint(x: w / 2, y: 0))
        
        return path
    }
}
