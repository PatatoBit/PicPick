import SwiftUI

struct TopBarView: View {
  let photoCount: Int

  @State private var datePickerVisible: Bool = false
  @Binding var selectedDate: Date

  var body: some View {
    VStack(spacing: 2) {
      HStack {
        Spacer()
        Text("today")
          .font(.largeTitle)
          .fontDesign(.rounded)
          .bold()
          .padding(.bottom, 2)
          .onTapGesture {
            datePickerVisible.toggle()
          }
        Spacer()
      }
      Text("\(photoCount) photos")
        .font(.subheadline)
        .foregroundColor(.gray)
    }

    if datePickerVisible {
      DatePicker(
        "Select Date",
        selection: Binding(
          get: { selectedDate ?? Date() },
          set: { newDate in selectedDate = newDate }
        ),
        displayedComponents: .date
      )
      .datePickerStyle(.graphical)
      .padding(.top, 8)
    }
  }
}
