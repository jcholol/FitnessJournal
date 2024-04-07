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
            Circle()
                .frame(width: 400, height: 400)
                .foregroundColor(.gray)
            Text("More")
                .foregroundColor(.white)
                .font(.system(size: 70, weight: .bold))
        }
    }
}

#Preview {
    More()
}
