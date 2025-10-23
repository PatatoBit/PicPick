import SwiftUI

/// Minimal placeholder for the photo area. Keeps the same public API
/// so you can reimplement fetching/rendering without breaking the rest
/// of the app. Replace with your own implementation when ready.
struct PhotoAreaView: View {
  let images: [UIImage]

  var body: some View {
    Group {
      if images.isEmpty {
        VStack {
          Spacer()
          Image(systemName: "photo.on.rectangle.angled")
            .resizable()
            .scaledToFit()
            .frame(width: 120, height: 120)
            .foregroundColor(.gray.opacity(0.6))
            .padding(.bottom, 8)
          Text("No photos for the selected date")
            .font(.title3)
            .foregroundColor(.gray)
          Spacer()
        }
      } else {
        // Simple vertical list of thumbnails for now — lightweight and easy
        // to replace with a deck/swipe UI when you're ready.
        ScrollView(.vertical) {
          LazyVStack(spacing: 12) {
            ForEach(Array(images.enumerated()), id: \.offset) { pair in
              Image(uiImage: pair.element)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 400)
                .cornerRadius(8)
                .shadow(radius: 2)
                .padding(.vertical, 4)
            }
          }
          .frame(maxWidth: .infinity)
          .padding()
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(.systemBackground))
  }
}

struct PhotoAreaView_Previews: PreviewProvider {
  static var previews: some View {
    PhotoAreaView(images: [])
  }
}
