//
//  dados.swift
//  ChartsEstudo
//
//  Created by Joao pedro Leonel on 14/10/25.
//

import Foundation
import SwiftUI


//dados que compoem o grafico
let ViewMonths: [ViewMonth] = [
    .init(date: Date.from(year: 2023, month: 1, day:1), viewCount:55000),
    .init(date: Date.from(year: 2023, month: 2, day:1), viewCount:60000),
    .init(date: Date.from(year: 2023, month: 3, day:1), viewCount:89000),
    .init(date: Date.from(year: 2023, month: 4, day:1), viewCount:79000),
    .init(date: Date.from(year: 2023, month: 5, day:1), viewCount:100000),
    .init(date: Date.from(year: 2023, month: 6, day:1), viewCount:90000),
    .init(date: Date.from(year: 2023, month: 7, day:1), viewCount:77000),
    .init(date: Date.from(year: 2023, month: 8, day:1), viewCount:22000),
    .init(date: Date.from(year: 2023, month: 9, day:1), viewCount:99000),
    .init(date: Date.from(year: 2023, month: 10, day:1), viewCount:89000),
    .init(date: Date.from(year: 2023, month: 11, day:1), viewCount:11000),
    .init(date: Date.from(year: 2023, month: 12, day:1), viewCount:110000),
    
    
    ]

//Como estou declarando os dados e como o formato da data esta funcionando
struct ViewMonth: Identifiable {
    let id = UUID()
    let date: Date
    let viewCount: Int
}

extension Date {
    static func from(year: Int, month: Int, day: Int)-> Date{
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
}
