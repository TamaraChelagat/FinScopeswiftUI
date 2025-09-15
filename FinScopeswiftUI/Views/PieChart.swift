//
//  PieCHart.swift
//  FinScopeswiftUI
//
//  Created by Student2 on 23/06/2025.
//

// PieChart.swift

import SwiftUI
import Charts

struct PieChart: View {
    let debts: [Debt]

    var body: some View {
        Chart(debts) { debt in
            SectorMark(
                angle: .value("Debt Share", debt.totalAmount),
                innerRadius: .ratio(0.5),
                angularInset: 1.5
            )
            .foregroundStyle(by: .value("Debt", debt.name))
        }
        .chartLegend(.visible)
    }
}


