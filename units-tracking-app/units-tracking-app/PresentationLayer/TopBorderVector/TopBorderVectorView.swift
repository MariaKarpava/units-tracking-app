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
            FirstLine()
            FirstCurve()
            Arc()
            SecondCurve()
            SecondLine()
        }.frame(width: 390, height: 27)
    }
}


struct FirstLine: View {
    var body: some View {
        let offsetY: CGFloat = 11
        
        let startFirstLine = CGPoint(x: 0, y: 27-offsetY)
        let endFirstLine = CGPoint(x: 144.5, y: 27-offsetY-0.05)
        
        Path { path in
            path.move(to: startFirstLine)
            path.addLine(to: endFirstLine)
        }
        .stroke(lineWidth: 0.2)
        .foregroundColor(.black)
    }
}

struct FirstCurve: View {
    var body: some View {
        let offsetY: CGFloat = 11
        let offsetX: CGFloat = 3.5
        
        Path { path in
            path.move(to: CGPoint(x: 141+offsetX, y: 27-offsetY)) // можно регyлировать по x
            path.addQuadCurve(
                to: CGPoint(x: 156.5+offsetX-0.3, y: 15-offsetY+0.3), // точно правильно
                control: CGPoint(x: 152+offsetX, y: 26-offsetY)
            )
        }
        .stroke(lineWidth: 0.2)
        .foregroundColor(.black)
    }
}


struct Arc: View {
    var body: some View {
        Path { path in
            path.addArc(
                center: CGPoint(x: 195, y: 15+6),
                radius: 39,
                startAngle: .degrees(0 - 25),
                endAngle: .degrees(180 + 25),
                clockwise: true)
        }
        .stroke(lineWidth: 0.2)
        .foregroundColor(.black)
    }
}

struct SecondCurve: View {
    var body: some View {
        let offsetY: CGFloat = 11
        let offsetX: CGFloat = 3.5
        
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
    }
}


struct SecondLine: View {
    var body: some View {
        let offsetY: CGFloat = 11
        
        let startSecondLine = CGPoint(x: 248, y: 27-offsetY)
        let endSecondLine = CGPoint(x: 390, y: 27-offsetY)
        
        Path { path in
            path.move(to: startSecondLine)
            path.addLine(to: endSecondLine)
        }
        .stroke(lineWidth: 0.1)
        .foregroundColor(.black)
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
