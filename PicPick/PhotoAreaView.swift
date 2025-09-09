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
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 16) {
            ForEach(images.indices, id: \.self) { index in
              Image(uiImage: images[index])
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .cornerRadius(12)
                .shadow(radius: 4)
            }
          }
          .padding()
        }
      }
    }
    .frame(maxWidth: .infinity)
    .background(Color(.systemBackground))
  }
}

struct PhotoAreaView_Previews: PreviewProvider {
  static var previews: some View {
    PhotoAreaView(images: [])
  }
}
