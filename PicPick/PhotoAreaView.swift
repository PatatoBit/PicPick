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
          ForEach(images.indices, id: \.self) { index in
            DraggablePhotoView(image: images[index])
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
      .cornerRadius(20)
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
      .animation(.spring(), value: offset)
  }
}

struct PhotoAreaView_Previews: PreviewProvider {
  static var previews: some View {
    PhotoAreaView(images: [])
  }
}
