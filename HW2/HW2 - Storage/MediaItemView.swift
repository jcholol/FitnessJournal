//
//  MediaItemView.swift
//  HW2 - Storage
//
//  Created by Yunho Cho on 4/21/24.
//

import PhotosUI
import SwiftData
import SwiftUI

struct MediaItemView: View {
//    @State var selectedPhoto: PhotosPickerItem?
//    @State var item = MediaItem()

    var body: some View {
        Text("hello world")
//        List {
//            Section {
//                if let imageData = item.image,
//                   let uiImage = UIImage(data: imageData)
//                {
//                    Image(uiImage: uiImage)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(maxWidth: .infinity, maxHeight: 300)
//                }
//
//                PhotosPicker(selection: $selectedPhoto,
//                             matching: .images,
//                             photoLibrary: .shared())
//                {
//                    Label("Add Image", systemImage: "photo")
//                }
//
//                if item.image != nil {
//                    Button(role: .destructive) {
//                        withAnimation {
//                            selectedPhoto = nil
//                            item.image = nil
//                        }
//                    } label: {
//                        Label("Remove Image", systemImage: "xmark")
//                            .foregroundStyle(.red)
//                    }
//                }
//            }
//        }
//        .task(id: selectedPhoto) {
//            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
//                item.image = data
//            }
//        }
    }
}
