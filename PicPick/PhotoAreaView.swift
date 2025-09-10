import SwiftUI

struct PhotoAreaView: View {
  let images: [UIImage]

  var body: some View {
    VStack {
      if images.isEmpty {
        Spacer()
        Text("No photos today")
          .font(.title)
          .foregroundColor(.gray)
        Spacer()
      } else {
        ZStack {
          // Show earlier photos behind, not draggable
          let nonDraggableImages = images.dropLast()
          ForEach(Array(nonDraggableImages.enumerated()), id: \.offset) { pair in
            let image = pair.element
            let index = pair.offset
            // Alternate rotation angles for peek effect
            // let rotationAngles: [Double] = [-8, 8, -6, 6, -4, 4, -2, 2]
            // let angle = rotationAngles[index % rotationAngles.count]
            Image(uiImage: image)
              .resizable()
              .scaledToFit()
              .frame(maxWidth: 400, maxHeight: 500)
              .padding(.bottom, CGFloat(index) * 2)
            // .rotationEffect(.degrees(angle))
          }
          // Show most recent photo on top, draggable
          if let last = images.last {
            DraggablePhotoView(image: last)
          }
        }
        .padding(15)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(.systemBackground))
  }
}

struct DraggablePhotoView: View {
  let image: UIImage
  @State private var offset: CGSize = .zero
  @State private var isDragging = false

  var rotationAngle: Double {
    // Rotate more as you drag further left/right
    Double(offset.width / 15)
  }

  var body: some View {
    Image(uiImage: image)
      .resizable()
      .scaledToFit()
      .frame(maxWidth: 350, maxHeight: 500)
      .offset(offset)
      .rotationEffect(.degrees(rotationAngle))
      .gesture(
        DragGesture()
          .onChanged { value in
            offset = value.translation
            isDragging = true
          }
          .onEnded { _ in
            // Snap back for now, no removal
            withAnimation(.spring()) {
              offset = .zero
              isDragging = false
            }
          }
      )
  }
}

struct PhotoAreaView_Previews: PreviewProvider {
  static var previews: some View {
    PhotoAreaView(images: [])
  }
}
