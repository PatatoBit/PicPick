import SwiftUI

struct BottomNavView: View {
    let activeDragDirection: DragDirection  // Add this parameter
    
    var body: some View {
        HStack {
            NavigationLink(destination: TrashView()) {
                pillButton(systemName: "xmark.bin", isActive: activeDragDirection == .left)
            }
            Spacer()
            
            NavigationLink(destination: BoxView()) {
                pillButton(systemName: "archivebox", isActive: activeDragDirection == .down)
            }
            Spacer()
            
            NavigationLink(destination: VaultView()) {
                pillButton(systemName: "lock", isActive: activeDragDirection == .right)
            }
        }
        .padding()
    }
    
    private func pillButton(systemName: String, isActive: Bool) -> some View {
        Image(systemName: systemName)
            .foregroundColor(isActive ? .white : Color(.systemGray))
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(isActive ? Color.accentColor : Color(.systemGray5))
            .clipShape(Capsule())
            .scaleEffect(isActive ? 1.1 : 1.0)  // Optional: subtle scale-up
            .animation(.easeOut(duration: 0.2), value: isActive)
    }
}

#Preview {
    ContentView()
}
