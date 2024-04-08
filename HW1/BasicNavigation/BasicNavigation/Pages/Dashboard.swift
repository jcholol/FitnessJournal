//
//  Dashboard.swift
//  BasicNavigation
//
//  Created by Yunho Cho on 4/7/24.
//

import SwiftUI

struct Dashboard: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.blue)
                .frame(width: .infinity, height: .infinity - 100)
            Text("Dashboard")
                .foregroundStyle(.white.gradient)
                .fontDesign(.rounded)
                .font(.system(size: 70, weight: .bold))
        }
    }
}

#Preview {
    Dashboard()
}
