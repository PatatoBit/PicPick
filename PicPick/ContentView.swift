//
//  ContentView.swift
//  PicPick
//
//  Created by Patato on 8/9/25.
//

import Photos
import SwiftUI

struct ContentView: View {
  @State private var images: [UIImage] = []
  @State private var openSelector: Bool = false
  @State private var selectedDate: Date = Date()

  var body: some View {
    VStack(spacing: 0) {
      TopBarView(photoCount: images.count)

      Toggle("Select Date", isOn: $openSelector)
        .padding(.horizontal)
        .padding(.top, 8)

      if openSelector {
        // Date picker
        DatePicker(
          "Select Date",  // Label for the DatePicker
          selection: $selectedDate,  // Binding to the selectedDate state variable
          displayedComponents: .date  // Display only the date component (month, day, year)
        )
        .onChange(of: selectedDate) { newDate in
          images.removeAll()
          fetchTodayPhotos(date: newDate)
        }
        .datePickerStyle(.graphical)  // Optional: Use graphical style for a calendar view

        Text("Selected Date: \(selectedDate.formatted(date: .long, time: .omitted))")

      }
      PhotoAreaView(images: images)
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)

      BottomNavView()
    }
    .onAppear {
      requestPermissionAndFetch()
    }
  }

  private func formatDate() -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter.string(from: Date())
  }

  private func requestPermissionAndFetch() {
    PHPhotoLibrary.requestAuthorization { status in
      if status == .authorized {
        fetchTodayPhotos()
      }
    }
  }

  private func fetchTodayPhotos(date: Date? = nil) {
    let calendar = Calendar.current
    let startOfDay = calendar.startOfDay(for: date ?? Date())
    var dayComponent = DateComponents()
    dayComponent.day = 1
    let endOfDay = calendar.date(byAdding: dayComponent, to: startOfDay)!

    let options = PHFetchOptions()
    options.predicate = NSPredicate(
      format: "creationDate >= %@ AND creationDate < %@", startOfDay as NSDate, endOfDay as NSDate)
    options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]

    let results = PHAsset.fetchAssets(with: .image, options: options)

    let imageManager = PHImageManager.default()
    let requestOptions = PHImageRequestOptions()
    requestOptions.isSynchronous = false
    requestOptions.deliveryMode = .highQualityFormat

    results.enumerateObjects { asset, _, _ in
      let targetSize = CGSize(width: 1000, height: 1000)
      imageManager.requestImage(
        for: asset,
        targetSize: targetSize,
        contentMode: .aspectFit,
        options: requestOptions
      ) { image, _ in
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
