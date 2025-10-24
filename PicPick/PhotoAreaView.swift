import SwiftUI

struct PhotoAreaView: View {
  let images: [UIImage]

  @State private var dragOffset = CGSize.zero

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

        ZStack {
          ForEach(Array(images.enumerated()), id: \.offset) { index, image in
            ZStack {

              Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 400)
                .cornerRadius(8)
                .shadow(radius: index == images.count - 1 ? 4 : 0)
                .padding(.vertical, 4)
                .offset(index == images.count - 1 ? dragOffset : .zero)  // Apply offset to top image
                .rotationEffect(
                  .degrees(
                    index == images.count - 1
                      ? Double(dragOffset.width / 15)  // Rotate based on horizontal drag
                      : 0
                  )
                )
                .gesture(
                  index == images.count - 1
                    ? DragGesture()
                      .onChanged { value in
                        dragOffset = value.translation
                      }
                      .onEnded { value in
                        withAnimation(.spring()) {
                          dragOffset = .zero
                        }
                      }
                    : nil
                )

            }

          }
        }
        .frame(maxWidth: .infinity)
        .padding()
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
