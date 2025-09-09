import SwiftUI

struct BottomNavView: View {
  var body: some View {
    HStack {
      pillButton(systemName: "xmark.bin")
      Spacer()
      pillButton(systemName: "archivebox")
      Spacer()
      pillButton(systemName: "lock")
    }
    .padding()
  }

  private func pillButton(systemName: String) -> some View {
    Button(action: {}) {
      Image(systemName: systemName)
        .foregroundColor(Color(.systemGray))
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
    .background(Color(.systemGray5))
    .clipShape(Capsule())
  }
}

struct BottomNavView_Previews: PreviewProvider {
  static var previews: some View {
    BottomNavView()
  }
}
