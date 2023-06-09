//
//  GraphView.swift
//  FX App
//
//  Created by Kuda Zata on 3/5/2023.
//

import SwiftUI
import Charts


struct GraphView: View {
    
    let timeSeriesArray: [TimeSeriesPoint]
    
    var body: some View {
        
        VStack {
            Chart {
                ForEach(timeSeriesArray) { point in
                    LineMark(x: .value("Date", point.date), y: .value("Rate", point.exchangeRate))
                }
            }.chartYAxis {
                AxisMarks(position: .leading)
            }.foregroundColor(.pink)
        }.padding()
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(timeSeriesArray: [TimeSeriesPoint]())
    }
}
