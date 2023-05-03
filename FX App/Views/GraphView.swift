//
//  GraphView.swift
//  FX App
//
//  Created by Kuda Zata on 3/5/2023.
//

import SwiftUI

struct GraphView: View {
    
    let dataPoints = [10, 20, 15, 30, 25, 50]
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                path.move(to: CGPoint(x: 0, y: geometry.size.height - CGFloat(dataPoints[0])))
                
                for i in 1..<dataPoints.count {
                    let x = geometry.size.width / CGFloat(dataPoints.count - 1) * CGFloat(i)
                    let y = geometry.size.height - CGFloat(dataPoints[i])
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }.stroke(Color.pink, lineWidth: 2)
        }.padding()
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}
