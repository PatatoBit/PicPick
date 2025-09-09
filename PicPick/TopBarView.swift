import SwiftUI

struct TopBarView: View {
  let photoCount: Int

  var body: some View {
    VStack(spacing: 2) {
      HStack {
        Spacer()
        Text("today")
          .font(.largeTitle)
          .fontDesign(.rounded)
          .bold()
          .padding(.bottom, 2)
        Spacer()
      }
      Text("\(photoCount) photos")
        .font(.subheadline)
        .foregroundColor(.gray)
    }
    // .background(Color(.systemGray6))
  }
}

struct TopBarView_Previews: PreviewProvider {
  static var previews: some View {
    TopBarView(photoCount: 5)
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
