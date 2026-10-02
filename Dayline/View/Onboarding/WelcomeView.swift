import SwiftUI

struct WelcomeView: View {
    @Binding var hasCompletedOnboarding: Bool

    var body: some View {
        ScrollView {
            VStack {

                WelcomeHeaderView()
                
                Image("newspaper")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                SelectConnectionsView()

                Button {
                    withAnimation {
                        hasCompletedOnboarding = true
                    }

                } label: {

                    HStack(spacing: 10) {

                        Text("Create My First Edition")
                            .font(.headline)

                        Image(systemName: "arrow.right")
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 54)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.blue)
                    }
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    WelcomeView(
        hasCompletedOnboarding: .constant(false)
    )
}
