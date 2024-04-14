//
//  Profiles.swift
//  BasicNavigation
//
//  Created by Yunho Cho on 4/7/24.
//

import SwiftUI

struct Profiles: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.indigo)
            Text("Profiles Page")
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.gradient)
                .fontDesign(.rounded)
                .font(.system(size: 70, weight: .bold))
        }
    }
}

#Preview {
    Profiles()
}
