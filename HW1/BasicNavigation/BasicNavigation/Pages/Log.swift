//
//  Log.swift
//  BasicNavigation
//
//  Created by Yunho Cho on 4/7/24.
//

import SwiftUI

struct Log: View {
    var body: some View {
        ZStack {
            Capsule()
                .fill(.yellow)
                .frame(width: 500, height: 500)
            Text("Food Log Page")
                .foregroundStyle(.white.gradient)
                .fontDesign(.monospaced)
                .font(.system(size: 45, weight: .bold))
        }
    }
}

#Preview {
    Log()
}
