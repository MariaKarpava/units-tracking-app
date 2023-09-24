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
            let width = geometry.size.width
            let height = geometry.size.height
            let radius: CGFloat = 39
            let circleCenterY: CGFloat = 21
            let center = CGPoint(x: width / 2, y: circleCenterY)
            let startAngle = Angle(degrees: 0 - 25)
            let endAngle = Angle(degrees: 180 + 25)
            let startPoint = CGPoint(
                x: center.x + radius * CGFloat(cos(startAngle.radians)),
                y: center.y + radius * CGFloat(sin(startAngle.radians))
            )
            let endPoint = CGPoint(
                x: center.x + radius * CGFloat(cos(endAngle.radians)),
                y: center.y + radius * CGFloat(sin(endAngle.radians))
            )
            
            FirstLine(width: width, center: center)
            FirstCurve(width: width, radius: radius, center: center, startAngle: startAngle, endAngle: endAngle, endPoint: endPoint)
            Arc(width: width, radius: radius, center: center, startAngle: startAngle, endAngle: endAngle)
            SecondCurve(width: width, radius: radius, center: center, startAngle: startAngle, moveToPoint: startPoint)
            SecondLine(width: width, center: center)
        }
    }
}




struct FirstLine: View {
    let width: CGFloat
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

struct FirstCurve: View {
    let width: CGFloat
    let radius: CGFloat
    let center: CGPoint
    let startAngle: Angle
    let endAngle: Angle
    let endPoint: CGPoint
    
    var body: some View {
        GeometryReader { geometry in
            let startPoint = CGPoint(x: center.x - 50.5, y: center.y - 5)
            let moveToPoint = endPoint
            let controlPoint = CGPoint(x: center.x - 39.5, y: center.y - 6)
            
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


struct Arc: View {
    let width: CGFloat
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


struct SecondCurve: View {
    let width: CGFloat
    let radius: CGFloat
    let center: CGPoint
    let startAngle: Angle
    let moveToPoint: CGPoint
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let center = CGPoint(x: width / 2, y: 21)
            let startPoint = CGPoint(x: center.x + 50.5, y: center.y - 5)
                        
            Path { path in
                    path.move(to: startPoint)
                    path.addQuadCurve(
                        to: moveToPoint,
                        control: CGPoint(x: center.x + 39.5, y: center.y - 6)
                    )
                }
                .stroke(lineWidth: 0.2)
                .foregroundColor(.black)
        }
    }
}


struct SecondLine: View {
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
