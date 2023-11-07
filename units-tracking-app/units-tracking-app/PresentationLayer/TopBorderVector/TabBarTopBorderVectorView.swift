//
//  CustomShapeView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 18/09/2023.
//

import SwiftUI
import CoreGraphics


struct ToShow: View {
    var body: some View {
        VStack{
            Spacer()
            TabBarTopBorderVectorView()  
        }
    }
}


struct TabBarTopBorderVectorView: View {
    
    func addUpperPartOfThePath(width: CGFloat, radius: CGFloat, circleCenterY: CGFloat, center: CGPoint, startAngle: Angle, endAngle: Angle) -> Path {
        let path = Path { p in
            // First line
            p.move(to: CGPoint(x: 0, y: center.y - 15))
            p.addLine(to: CGPoint(x: center.x - 50.5, y: center.y - 15))
            
            // First curve
            p.addQuadCurve(
                to: CGPoint(x: center.x + radius * CGFloat(cos(endAngle.radians)),
                            y: center.y + radius * CGFloat(sin(endAngle.radians))),
                control: CGPoint(x: center.x - 38, y: center.y - 15)
            )
            
            // Arc
            // Changed start and end angles
            p.addArc(center: center, radius: radius, startAngle: endAngle, endAngle: startAngle, clockwise: false)
            
            p.addQuadCurve(
                to: CGPoint(x: center.x + 50.5, y: center.y - 15),
                control: CGPoint(x: center.x + 38, y: center.y - 15)
            )
            
            // Second line
            p.addLine(to: CGPoint(x: width, y: center.y - 15))
        }
          return path
    }
    
    func myPath(width: CGFloat, radius: CGFloat, circleCenterY: CGFloat, center: CGPoint, startAngle: Angle, endAngle: Angle, lowerBorderOffset: Double) -> Path {
        let path = Path { p in
            // First line
            p.move(to: CGPoint(x: 0, y: center.y - 15))
            p.addLine(to: CGPoint(x: center.x - 50.5, y: center.y - 15))
            
            // First curve
            p.addQuadCurve(
                to: CGPoint(x: center.x + radius * CGFloat(cos(endAngle.radians)),
                            y: center.y + radius * CGFloat(sin(endAngle.radians))),
                control: CGPoint(x: center.x - 38, y: center.y - 15)
            )
            
            // Arc
            // Changed start and end angles
            p.addArc(center: center, radius: radius, startAngle: endAngle, endAngle: startAngle, clockwise: false)
            
            p.addQuadCurve(
                to: CGPoint(x: center.x + 50.5, y: center.y - 15),
                control: CGPoint(x: center.x + 38, y: center.y - 15)
            )
            
            // Second line
            p.addLine(to: CGPoint(x: width, y: center.y - 15))
            
            // Right vertical line
            p.addLine(to: CGPoint(x: width, y: center.y + lowerBorderOffset))
            
            // Bottom line
            p.addLine(to: CGPoint(x: 0, y: center.y + lowerBorderOffset))
            
            // Left vertical line
            p.addLine(to: CGPoint(x: 0, y: center.y + lowerBorderOffset))
        }
       return  path
    }

    var body: some View {
        GeometryReader { geometry in
            let width: CGFloat = geometry.size.width
            let radius: CGFloat = 39
            let circleCenterY: CGFloat = 39 // should be = radius (39)
            let center = CGPoint(x: width / 2, y: circleCenterY)
            let startAngle = Angle(degrees: 0 - 33)
            let endAngle = Angle(degrees: 180 + 33)
            let lowerBorderOffset: Double = 5
            
            myPath(width: width, radius: radius, circleCenterY: circleCenterY, center: center, startAngle: startAngle, endAngle: endAngle, lowerBorderOffset: lowerBorderOffset)
                .fill(.white)
                .overlay {
                    addUpperPartOfThePath(width: width, radius: radius, circleCenterY: circleCenterY, center: center, startAngle: startAngle, endAngle: endAngle)
                        .stroke(.black, lineWidth: 0.2)
                }
        }.frame(height: 44)
    }
}








    struct ToShow_Previews: PreviewProvider {
        static var previews: some View {
            ToShow()
                .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
                .previewDisplayName("iPhone 14")

            ToShow()
                .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
                .previewDisplayName("iPhone 14 Pro Max")
        }
    }






