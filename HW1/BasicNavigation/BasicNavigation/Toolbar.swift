//
//  Toolbar.swift
//  BasicNavigation
//
//  Created by Yunho Cho on 4/7/24.
//

import SwiftUI

struct Toolbar: View {
    var body: some View {
        HStack {
            TabView {
                Dashboard()
                    .tabItem {
                        Image(systemName: "square.grid.3x3.middle.fill")
                        Text("Dashboard")
                    }
                Plans()
                    .tabItem {
                        Image(systemName: "pencil.and.list.clipboard")
                        Text("Plans")
                    }
                More()
                    .tabItem {
                        Image(systemName: "ellipsis")
                        Text("More")
                    }
            }
        }
    }
}

#Preview {
    Toolbar()
}
