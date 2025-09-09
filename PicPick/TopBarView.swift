import SwiftUI

struct TopBarView: View {
  var body: some View {
    HStack {
      Spacer()
      Text("today")
        .font(.largeTitle)
        .fontDesign(.rounded)
        .bold()
        .padding()
      Spacer()
    }
    // .background(Color(.systemGray6))
  }
}

struct TopBarView_Previews: PreviewProvider {
  static var previews: some View {
    TopBarView()
  }
}
