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
            Image(uiImage: images[index])
              .resizable()
              .scaledToFit()
          }
        }
        .padding(15)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(.systemBackground))
    // .border(Color.green, width: 2)
  }
}

struct PhotoAreaView_Previews: PreviewProvider {
  static var previews: some View {
    PhotoAreaView(images: [])
  }
}
