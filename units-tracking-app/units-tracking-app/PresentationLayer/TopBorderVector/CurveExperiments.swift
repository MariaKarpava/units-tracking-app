//
//  CurveExperiments.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 19/09/2023.
//

import SwiftUI

struct CurveExperiments: View {
    var body: some View {
        GeometryReader { geometry in
            
            
            
            
            let offsetY = 8
            let offsetX = 10
            
            let p1 = CGPoint(x: 0, y: 27 + offsetY)
            let a = CGPoint(x: 158 - offsetX, y: 27 + offsetY)
            let b = CGPoint(x: 158, y: 27)
            let c = CGPoint(x: 158 - 2.4, y: 27 + 8)
            let p5 = CGPoint(x: 232, y: 27)
            
            Path { path in
                path.move(to: p1)
                path.addLine(to: a)
            }
            .stroke(lineWidth: 0.1)
            
            
            
            Path { path in
                path.move(to: a)
                path.addQuadCurve(
                    to: b,
                    control: c
                )
            }
            .stroke(lineWidth: 0.1)
            .foregroundColor(.red)
            
            Path { path in
                path.move(to: b)
                path.addCurve(
                    to: p5,
                    control1: CGPoint(x: 172, y: -8.8),
                    control2: CGPoint(x: 217, y: -8.8)
                )
            }
            .stroke(lineWidth: 0.1)
            
//            Path { path in
//                path.move(to: CGPoint(x: 232, y: 27))
//                path.addLine(to: CGPoint(x: 390, y: 27))
//            }
//            .stroke(lineWidth: 1)
            
            
            let s = CGPoint(x: 100, y: 100)
            let e = CGPoint(x: 130, y: 70)
            let c1 = CGPoint(x: s.x + 10, y: s.y)
            let c2 = CGPoint(x: e.x - 20, y: e.y)
            
            Path { path in
                path.move(to: s)
                path.addCurve(
                    to: e,
                    control1: c1,
                    control2: c2
                )
            }
            .stroke(lineWidth: 0.5)
            .foregroundColor(.red)
            
            
        }.frame(width: 390, height: 200
        )
    }
}

struct CurveExperiments_Previews: PreviewProvider {
    static var previews: some View {
        CurveExperiments()
    }
}
