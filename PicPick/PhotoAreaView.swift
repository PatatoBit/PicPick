import SwiftUI

struct PhotoAreaView: View {
  var body: some View {
    VStack {
      Spacer()
      Text("Photo Area")
        .font(.title)
        .foregroundColor(.gray)
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .background(Color(.systemBackground))
  }
}

struct PhotoAreaView_Previews: PreviewProvider {
  static var previews: some View {
    PhotoAreaView()
  }
}
