//
//  Plans.swift
//  HelloWorld
//
//  Created by Yunho Cho on 4/7/24.
//

import SwiftUI

struct Plans: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 400, height: 400)
                .foregroundColor(.red)
            Text("Plans")
                .foregroundColor(.white)
                .font(.system(size: 70, weight: .bold))
        }
    }
}

#Preview {
    Plans()
}
