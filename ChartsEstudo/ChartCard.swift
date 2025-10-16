//
//  ChartCard.swift
//  ChartsEstudo
//
//  Created by Joao pedro Leonel on 14/10/25.
//

import SwiftUI

struct ChartCard<Content: View>: View {
    let title: String
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.top)
            
            content
                .frame(height: 200) // Altura padrão para os gráficos
                .padding(.horizontal)
                .padding(.bottom)
        }
        .background(Color.white.opacity(0.05)) // Fundo cinza escuro translúcido
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.1), lineWidth: 1) // Borda sutil
        )
    }
}
