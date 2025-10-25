import SwiftUI

struct TopBarView: View {
  let photoCount: Int

  @State private var datePickerVisible: Bool = false
  @Binding var selectedDate: Date

  private var displayText: String {
    let calendar = Calendar.current
    if calendar.isDateInToday(selectedDate) {
      return "today"
    } else {
      let formatter = DateFormatter()
      formatter.dateFormat = "MMM d, yyyy"
      return formatter.string(from: selectedDate)
    }
  }

  var body: some View {
    VStack {
      VStack(spacing: 2) {
        HStack {
          Spacer()
          Text(displayText)
            .font(.largeTitle)
            .fontDesign(.rounded)
            .bold()
            .padding(.bottom, 2)
            .onTapGesture {
              withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                datePickerVisible.toggle()
              }
            }
            .animation(.easeInOut(duration: 0.3), value: displayText)
            .foregroundColor(datePickerVisible ? .blue : .primary)
          Spacer()
        }
        Text("\(photoCount) photos")
          .font(.subheadline)
          .foregroundColor(.gray)
      }
      .zIndex(0)

      if datePickerVisible {
        ZStack {
          VStack(spacing: 0) {

            DatePicker(
              "Select Date",
              selection: $selectedDate,
              displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .padding()
            .background(
              RoundedRectangle(cornerRadius: 16)
                .fill(Color(uiColor: .systemBackground))
                .shadow(color: .black.opacity(0.2), radius: 15, x: 0, y: 5)
            )
            .padding(.horizontal, 20)

            Spacer()
          }
        }
        .transition(
          .asymmetric(
            insertion: .opacity,
            removal: .opacity
          )
        )
        .zIndex(1)

      }
    }
    .padding(.bottom, 20)
    .clipShape(
      .rect(
        topLeadingRadius: 0,
        bottomLeadingRadius: 20,
        bottomTrailingRadius: 20,
        topTrailingRadius: 0
      )
    )
  }
}

#Preview {
  ContentView()
}
