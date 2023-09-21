//
//  CustomShapeView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 18/09/2023.
//

import SwiftUI
import CoreGraphics


struct TopBorderVectorView: View {
    
    var body: some View {
        GeometryReader { geometry in
            let offsetY: CGFloat = 11
            let offsetX: CGFloat = 1
            
            let startFirstLine = CGPoint(x: 0, y: 27-offsetY)
            let endFirstLine = CGPoint(x: 142, y: 27-offsetY)
            
            let startSecondLine = CGPoint(x: 248, y: 27-offsetY)
            let endSecondLine = CGPoint(x: 360, y: 27-offsetY)
            
            // First horizontal line
            Path { path in
                path.move(to: startFirstLine)
                path.addLine(to: endFirstLine)
            }
            .stroke(lineWidth: 0.1)
            .foregroundColor(.black)
            
            // First connection between arc and line
            Path { path in
                path.move(to: CGPoint(x: 141+offsetX, y: 27-offsetY)) // можно регyлировать по x
                path.addQuadCurve(
                    to: CGPoint(x: 156.5+offsetX, y: 15-offsetY), // точно правильно
                    control: CGPoint(x: 155+offsetX, y: 26-offsetY)
                )
            }
            .stroke(lineWidth: 0.1)
            .foregroundColor(.red)
            
            // Arc
            Path { path in
                path.addArc(center: CGPoint(x: 195, y: 15), radius: 39, startAngle: .degrees(0), endAngle: .degrees(180), clockwise: true)
            }
            .trim(from: 0, to: 0.92)
            .trim(from: 0.08, to: 1)
            .stroke(lineWidth: 0.1)
            
            // Second connection between arc and line
            Path { path in
                    path.move(to: CGPoint(x: 141 + offsetX, y: 27 - offsetY))
                    path.addQuadCurve(
                        to: CGPoint(x: 156.5 + offsetX, y: 15 - offsetY),
                        control: CGPoint(x: 155 + offsetX, y: 26 - offsetY)
                    )
                }
                .stroke(lineWidth: 0.1)
                .foregroundColor(.black)
                .scaleEffect(x: -1, y: 1, anchor: .center)
            
            // Second line
            Path { path in
                path.move(to: startSecondLine)
                path.addLine(to: endSecondLine)
            }
            .stroke(lineWidth: 0.1)
            .foregroundColor(.black)
            
        }.frame(width: 390, height: 27
        )
    }
}


struct TopBorderVectorView_Previews: PreviewProvider {
    static var previews: some View {
        TopBorderVectorView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")

        TopBorderVectorView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
    }
}
