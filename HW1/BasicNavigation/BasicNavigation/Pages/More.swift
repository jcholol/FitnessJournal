//
//  More.swift
//  BasicNavigation
//
//  Created by Yunho Cho on 4/7/24.
//

import SwiftUI

struct More: View {
    var body: some View {
        ZStack {
            Ellipse()
                .fill(.gray)
                .frame(width: 400, height: 100)
            Text("More Page")
                .foregroundStyle(.white.gradient)
                .fontDesign(.serif)
                .font(.system(size: 65, weight: .bold))
        }
    }
}

#Preview {
    More()
}
