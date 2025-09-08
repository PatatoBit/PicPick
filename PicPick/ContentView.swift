//
//  ContentView.swift
//  PicPick
//
//  Created by Patato on 8/9/25.
//

import SwiftUI
import Photos

struct ContentView: View {
    @State private var images: [UIImage] = []

    var body: some View {
        ScrollView {
            VStack {
                if images.isEmpty {
                    Text("No photos today")
                } else {
                    ForEach(images.indices, id: \.self) { index in
                        Image(uiImage: images[index])
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                }
            }
        }
        .onAppear {
            requestPermissionAndFetch()
        }
    }
    
    private func requestPermissionAndFetch() {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                fetchTodayPhotos()
            }
        }
    }
    
    private func fetchTodayPhotos() {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        var dayComponent = DateComponents()
        dayComponent.day = 1
        let endOfDay = calendar.date(byAdding: dayComponent, to: startOfDay)!

        let options = PHFetchOptions()
        options.predicate = NSPredicate(format: "creationDate >= %@ AND creationDate < %@", startOfDay as NSDate, endOfDay as NSDate)
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]

        let results = PHAsset.fetchAssets(with: .image, options: options)

        let imageManager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = .highQualityFormat

        results.enumerateObjects { asset, _, _ in
            let targetSize = CGSize(width: 500, height: 500)
            imageManager.requestImage(for: asset,
                                      targetSize: targetSize,
                                      contentMode: .aspectFit,
                                      options: requestOptions) { image, _ in
                if let img = image {
                    DispatchQueue.main.async {
                        self.images.append(img)
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
