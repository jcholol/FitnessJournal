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
            Circle()
                .frame(width: 400, height: 400)
                .foregroundColor(/*@START_MENU_TOKEN@*/ .blue/*@END_MENU_TOKEN@*/)
            Text("Dashboard")
                .foregroundColor(.white)
                .font(.system(size: 70, weight: .bold))
        }
    }
}

#Preview {
    Dashboard()
}
