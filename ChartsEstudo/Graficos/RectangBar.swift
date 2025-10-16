//
//  RectangBar.swift
//  ChartsEstudo
//
//  Created by Joao pedro Leonel on 14/10/25.
//

import Foundation
import SwiftUI
import Charts

struct RectangBar: View {
    var body: some View {
        //Grafico de retangulo
        Chart{
            // linha de meta (pontilhada mostrando um lugar para atingir)
            RuleMark(y:.value("Goal", 80000))
                .foregroundStyle(Color.mint)
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                .annotation(alignment: .leading){
                    Text("Goal")
                        .font(.caption)
                        .foregroundColor(Color.secondary)
                }
            
            
            //printando o grafico de barro e declarando o eixo x e y
            ForEach(ViewMonths) { viewMonth in
                RectangleMark(
                    x: .value("Month", viewMonth.date, unit: .month),
                    y: .value("Views", viewMonth.viewCount)
                )
                .foregroundStyle(Color.green.gradient)
                .cornerRadius(10)
            }
            
        }
        .frame(height: 180)
    }
}
