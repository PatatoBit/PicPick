import SwiftUI

struct BottomNavView: View {
  var body: some View {
    HStack {
      Spacer()
      Button(action: {}) {
        Image(systemName: "photo")
        Text("Gallery")
      }
      Spacer()
      Button(action: {}) {
        Image(systemName: "camera")
        Text("Camera")
      }
      Spacer()
    }
    .padding()
    .background(Color(.systemGray5))
  }
}

struct BottomNavView_Previews: PreviewProvider {
  static var previews: some View {
    BottomNavView()
  }
}
