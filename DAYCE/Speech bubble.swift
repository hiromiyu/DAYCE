//
//  Speech bubble.swift
//  DAYCE
//
//  Created by ひろ on 2023/03/05.
//

import SwiftUI

struct Speech_bubble: View {
    @EnvironmentObject var speechbubbleData: SpeechbubbleData
    
    var body: some View {
        VStack {
            Button("左") {
                speechbubbleData.positionleftunder.toggle()
            }
            
            Button("右") {
                speechbubbleData.positionrightunder.toggle()
            }
            
            Text("iOS表示サンプル")
                .padding(4)
            BalloonText("こんにちは")
                .padding(4)
            BalloonText("逆向き", mirrored: true)
                .padding(4)
            
            
        }
    }
}

struct BalloonText: View {
    let text: String
    let color: Color
    let mirrored: Bool
    
    init(_ text: String,
         color: Color = (.white),
         mirrored: Bool = false
    ) {
        self.text = text
        self.color = color
        self.mirrored = mirrored
    }

    var body: some View {
        let cornerRadius = 30.0
        
        Text(text)
            .padding(.leading, 10 + (mirrored ? cornerRadius / 2 : 0))
            .padding(.trailing, 10 + (!mirrored ? cornerRadius / 2 : 0))
            .padding(.vertical, 20)
            .background(BalloonShape(
                cornerRadius: cornerRadius,
                color: color,
                mirrored: mirrored)
            )
    }
}

struct BalloonShape: View {
    @EnvironmentObject var speechbubbleData: SpeechbubbleData
    var cornerRadius: Double
    var color: Color
    var mirrored = false
    
    var body: some View {
        
            
        if speechbubbleData.positionleftunder {
            GeometryReader { geometry in
                Path { path in
                    let tailSize = CGSize(
                        width: cornerRadius / 2,
                        height: cornerRadius / 2)
                    let shapeRect = CGRect(
                        x: 0,
                        y: 0,
                        width: geometry.size.width,
                        height: geometry.size.height)
                    
                    // 時計まわりに描いていく
                    
                    // 左上角丸
                    path.addArc(
                        center: CGPoint(
                            x: shapeRect.minX + cornerRadius,
                            y: shapeRect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 180),
                        endAngle: Angle(degrees: 279), clockwise: false)
                    
                    // 右上角丸
                    path.addArc(
                        center: CGPoint(
                            x: shapeRect.maxX - cornerRadius - tailSize.width,
                            y: shapeRect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 270),
                        endAngle: Angle(degrees: 270 + 45), clockwise: false)
                    
                    // しっぽ上部
                    path.addQuadCurve(
                        to: CGPoint(
                            x: shapeRect.maxX,
                            y: shapeRect.minY),
                        control: CGPoint(
                            x: shapeRect.maxX - (tailSize.width / 2),
                            y: shapeRect.minY))
                    
                    // しっぽ下部
                    path.addQuadCurve(
                        to: CGPoint(
                            x: shapeRect.maxX - tailSize.width,
                            y: shapeRect.minY + (cornerRadius / 2) + tailSize.height),
                        control: CGPoint(
                            x: shapeRect.maxX - (tailSize.width / 2),
                            y: shapeRect.minY))
                    
                    // 右下角丸
                    path.addArc(
                        center: CGPoint(
                            x: shapeRect.maxX - cornerRadius - tailSize.width,
                            y: shapeRect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 90), clockwise: false)
                    
                    // 左下角丸
                    path.addArc(
                        center: CGPoint(
                            x: shapeRect.minX + cornerRadius,
                            y: shapeRect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 90),
                        endAngle: Angle(degrees: 180), clockwise: false)
                }
                .fill(self.color)
                .shadow(radius: 8)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 0, z: 1))
            }
        } else if speechbubbleData.positionrightunder{
            GeometryReader { geometry in
                Path { path in
                    let tailSize = CGSize(
                        width: cornerRadius / 2,
                        height: cornerRadius / 2)
                    let shapeRect = CGRect(
                        x: 0,
                        y: 0,
                        width: geometry.size.width,
                        height: geometry.size.height)
                    
                    // 時計まわりに描いていく
                    
                    // 左上角丸
                    path.addArc(
                        center: CGPoint(
                            x: shapeRect.minX + cornerRadius,
                            y: shapeRect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 180),
                        endAngle: Angle(degrees: 279), clockwise: false)
                    
                    // 右上角丸
                    path.addArc(
                        center: CGPoint(
                            x: shapeRect.maxX - cornerRadius - tailSize.width,
                            y: shapeRect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 270),
                        endAngle: Angle(degrees: 270 + 45), clockwise: false)
                    
                    // しっぽ上部
                    path.addQuadCurve(
                        to: CGPoint(
                            x: shapeRect.maxX,
                            y: shapeRect.minY),
                        control: CGPoint(
                            x: shapeRect.maxX - (tailSize.width / 2),
                            y: shapeRect.minY))
                    
                    // しっぽ下部
                    path.addQuadCurve(
                        to: CGPoint(
                            x: shapeRect.maxX - tailSize.width,
                            y: shapeRect.minY + (cornerRadius / 2) + tailSize.height),
                        control: CGPoint(
                            x: shapeRect.maxX - (tailSize.width / 2),
                            y: shapeRect.minY))
                    
                    // 右下角丸
                    path.addArc(
                        center: CGPoint(
                            x: shapeRect.maxX - cornerRadius - tailSize.width,
                            y: shapeRect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 90), clockwise: false)
                    
                    // 左下角丸
                    path.addArc(
                        center: CGPoint(
                            x: shapeRect.minX + cornerRadius,
                            y: shapeRect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 90),
                        endAngle: Angle(degrees: 180), clockwise: false)
                }
                .fill(self.color)
                .shadow(radius: 8)
                .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0))
            }
        } else {
            GeometryReader { geometry in
                Path { path in
                    let tailSize = CGSize(
                        width: cornerRadius / 2,
                        height: cornerRadius / 2)
                    let shapeRect = CGRect(
                        x: 0,
                        y: 0,
                        width: geometry.size.width,
                        height: geometry.size.height)
                    
                    // 時計まわりに描いていく
                    
                    // 左上角丸
                    path.addArc(
                        center: CGPoint(
                            x: shapeRect.minX + cornerRadius,
                            y: shapeRect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 180),
                        endAngle: Angle(degrees: 279), clockwise: false)
                    
                    // 右上角丸
                    path.addArc(
                        center: CGPoint(
                            x: shapeRect.maxX - cornerRadius - tailSize.width,
                            y: shapeRect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 270),
                        endAngle: Angle(degrees: 270 + 45), clockwise: false)
                    
                    // しっぽ上部
                    path.addQuadCurve(
                        to: CGPoint(
                            x: shapeRect.maxX,
                            y: shapeRect.minY),
                        control: CGPoint(
                            x: shapeRect.maxX - (tailSize.width / 2),
                            y: shapeRect.minY))
                    
                    // しっぽ下部
                    path.addQuadCurve(
                        to: CGPoint(
                            x: shapeRect.maxX - tailSize.width,
                            y: shapeRect.minY + (cornerRadius / 2) + tailSize.height),
                        control: CGPoint(
                            x: shapeRect.maxX - (tailSize.width / 2),
                            y: shapeRect.minY))
                    
                    // 右下角丸
                    path.addArc(
                        center: CGPoint(
                            x: shapeRect.maxX - cornerRadius - tailSize.width,
                            y: shapeRect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 90), clockwise: false)
                    
                    // 左下角丸
                    path.addArc(
                        center: CGPoint(
                            x: shapeRect.minX + cornerRadius,
                            y: shapeRect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 90),
                        endAngle: Angle(degrees: 180), clockwise: false)
                }
                .fill(self.color)
                .shadow(radius: 8)
                .rotation3DEffect(.degrees(mirrored ? 180 : 0), axis: (x: 0, y: 1, z: 0))
            }
        }
    }
}

struct Speech_bubble_Previews: PreviewProvider {
    static var previews: some View {
        Speech_bubble()
            .environmentObject(SpeechbubbleData())
    }
}
