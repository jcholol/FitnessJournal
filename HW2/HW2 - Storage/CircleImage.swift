//
//  CircleImage.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 4/21/24.
//

import SwiftUI

struct CircleImage: View {
    var image: Image

    var body: some View {
        image
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

#Preview {
    CircleImage(image: Image("hello"))
}
