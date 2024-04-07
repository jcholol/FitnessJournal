//
//  Plans.swift
//  BasicNavigation
//
//  Created by Yunho Cho on 4/7/24.
//

import SwiftUI

struct Plans: View {
    var body: some View {
        ZStack {
            Capsule()
                .fill(.red)
                .frame(width: 300, height: 100)
            Text("Plans Page")
                .foregroundStyle(.white.gradient)
                .fontDesign(.monospaced)
                .font(.system(size: 45, weight: .bold))
        }
    }
}

#Preview {
    Plans()
}
