//
//  ContentView.swift
//  ChartsEstudo
//
//  Created by Joao pedro Leonel on 14/10/25.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    @State private var rawSelectedDate: Date?
    
    var selectedViewMonth: ViewMonth? {
        guard let selectedDate = rawSelectedDate else { return nil }
        return ViewMonths.first(where: { month in
            Calendar.current.isDate(selectedDate, equalTo: month.date, toGranularity: .month)
        })
    }
    
    var body: some View {
        ZStack {
            // Fundo preto para toda a tela
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 15) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) { // Container principal para alinhar à esquerda
                        
                        // Cabeçalho estilizado
                        VStack(alignment: .leading) {
                            Text("Valor Total Vendido")
                                .font(.title2).bold()
                                .foregroundColor(.white)
                            
                            Text("R$ \(ViewMonths.reduce(0){ $0 + $1.viewCount })")
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundColor(.green) // Cor de destaque
                        }
                        .padding(.bottom, 15)
                        
                        // Cards para cada gráfico
                        ChartCard(title: "Gráfico de Barras") {
                            graBar()
                        }
                        
                        ChartCard(title: "Gráfico de Linha") {
                            LineBar()
                        }
                        
                        ChartCard(title: "Gráfico de Pontos") {
                            PointBar()
                        }
                        
                        ChartCard(title: "Gráfico de Área") {
                            AreaBar()
                        }
                        
                        ChartCard(title: "Gráfico de Regra") {
                            RuleBar()
                        }
                        
                        ChartCard(title: "Gráfico de Retângulo") {
                            RectangBar()
                        }
                        
                        //Mostra ate onde o grafico pode chegar o limite dele:
                        //  .chartYScale(domain: 0...2000000)
                        
                        //Oculta os eixos do grafico:
                        //  .chartXAxis(.hidden)
                        //  .chartYAxis(.hidden)
                        
                        //Fundo do grafico
                        //  .chartPlotStyle{ plotContent in
                        //      plotContent
                        //          .background(.black.opacity(0.05))
                        //          .border(Color.black, width: 1)
                        //
                        //  }
                    }
                }
//                .opacity(rawSelectedDate == nil || viewMonth.date == selectedViewMonth?.date ? 1.0 : 0.3)
                //Ajustar como aparece o tempo do eixo X:
                .chartXSelection(value: $rawSelectedDate.animation(.easeInOut))
                .chartXAxis {
                    AxisMarks(values: ViewMonths.map{ $0.date}) { date in
                        // Estilo dos eixos para o tema escuro
                        AxisGridLine().foregroundStyle(Color.white.opacity(0.3))
                        AxisTick().foregroundStyle(Color.white.opacity(0.5))
                        AxisValueLabel(format: .dateTime.month(.narrow))
                            .foregroundStyle(Color.white) // Texto do eixo em branco
                    }
                }
                
            }
            .padding()
        }
    }
}


#Preview {
    ContentView()
}

