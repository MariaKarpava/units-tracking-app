//
//  CustomShapeView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 18/09/2023.
//

import SwiftUI
import CoreGraphics

// Color: F0F0F0
struct TopBorderVectorView: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let radius: CGFloat = 39
            let circleCenterY: CGFloat = 0
            let center = CGPoint(x: width / 2, y: circleCenterY)
            let startAngle = Angle(degrees: 0 - 25)
            let endAngle = Angle(degrees: 180 + 25)
            
            FirstLine(center: center)
            FirstCurve(center: center, radius: radius, endAngle: endAngle)
            Arc(radius: radius, center: center, startAngle: startAngle, endAngle: endAngle)
            SecondCurve(center: center, radius: radius, startAngle: startAngle)
            SecondLine(width: width, center: center)
        }
    }
}




private struct FirstLine: View {
    let center: CGPoint
    
    var body: some View {
        GeometryReader { geometry in
            let startFirstLine = CGPoint(x: 0, y:  center.y - 5)
            let endFirstLine = CGPoint(x: center.x - 50.5, y: center.y - 5)
           
            Path { path in
                path.move(to: startFirstLine)
                path.addLine(to: endFirstLine)
            }
            .stroke(lineWidth: 0.2)
        .foregroundColor(.black)
        }
    }
}

private struct FirstCurve: View {
    let center: CGPoint
    let radius: CGFloat
    let endAngle: Angle
    
    var body: some View {
        GeometryReader { geometry in
            let startPoint = CGPoint(x: center.x - 50.5, y: center.y - 5)
            let controlPoint = CGPoint(x: center.x - 39.5, y: center.y - 6)
            let moveToPoint = CGPoint(
                x: center.x + radius * CGFloat(cos(endAngle.radians)),
                y: center.y + radius * CGFloat(sin(endAngle.radians))
            )
            
            Path { path in
                path.move(to: startPoint)
                path.addQuadCurve(
                    to: moveToPoint,
                    control: controlPoint
                )
            }
            .stroke(lineWidth: 0.2)
        .foregroundColor(.black)
        }
    }
}


private struct Arc: View {
    let radius: CGFloat
    let center: CGPoint
    let startAngle: Angle
    let endAngle: Angle
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                path.addArc(
                    center: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: true)
            }
            .stroke(lineWidth: 0.2)
            .foregroundColor(.black)
        }
    }
}


private struct SecondCurve: View {
    let center: CGPoint
    let radius: CGFloat
    let startAngle: Angle
    
    var body: some View {
        GeometryReader { geometry in
            let startPoint = CGPoint(x: center.x + 50.5, y: center.y - 5)
            let controlPoint = CGPoint(x: center.x + 39.5, y: center.y - 6)
            let moveToPoint = CGPoint(
                x: center.x + radius * CGFloat(cos(startAngle.radians)),
                y: center.y + radius * CGFloat(sin(startAngle.radians))
            )
                        
            Path { path in
                    path.move(to: startPoint)
                    path.addQuadCurve(
                        to: moveToPoint,
                        control: controlPoint
                    )
                }
                .stroke(lineWidth: 0.2)
                .foregroundColor(.black)
        }
    }
}


private struct SecondLine: View {
    let width: CGFloat
    let center: CGPoint
    
    var body: some View {
        GeometryReader { geometry in
            let startSecondLine = CGPoint(x: center.x + 50.5, y: center.y - 5)
            let endSecondLine = CGPoint(x: width, y: center.y - 5)
            
            Path { path in
                path.move(to: startSecondLine)
                path.addLine(to: endSecondLine)
            }
            .stroke(lineWidth: 0.2)
        .foregroundColor(.black)
        }
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
