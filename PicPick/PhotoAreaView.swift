import SwiftUI

struct PhotoAreaView: View {
  let images: [UIImage]
  @Binding var dragDirection: DragDirection  // Binding passed from parent

  @State private var dragOffset = CGSize.zero  // Local state for drag tracking

  // Computed property to calculate direction from offset
  private var computedDragDirection: DragDirection {
    let threshold: CGFloat = 80
    if abs(dragOffset.width) > abs(dragOffset.height) {
      if dragOffset.width < -threshold {
        return .left
      } else if dragOffset.width > threshold {
        return .right
      }
    } else {
      if dragOffset.height > threshold { return .down }
    }
    return .none
  }

  var body: some View {
    Group {
      if images.isEmpty {
        VStack {
          Spacer()
          Image(systemName: "photo.on.rectangle.angled")
            .resizable()
            .scaledToFit()
            .frame(width: 60   , height: 60)
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
                        dragDirection = computedDragDirection  // Update parent
                      }
                      .onEnded { value in
                        withAnimation(.spring()) {
                          dragOffset = .zero
                          dragDirection = .none
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

#Preview {
  ContentView()
}
