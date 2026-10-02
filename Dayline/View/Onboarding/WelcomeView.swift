import SwiftUI

struct WelcomeView: View {
    @Binding var hasCompletedOnboarding: Bool
    @StateObject private var viewModel = WelcomeViewModel()

    var body: some View {
        ScrollView {
            VStack {
                WelcomeHeaderView()
                Image("newspaper")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                SelectConnectionsView(viewModel: viewModel.connectionsViewModel)
                Button {
                    viewModel.completeOnboarding()
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
        .onChange(of: viewModel.isReadyToFinishOnboarding) { _, newValue in
            guard newValue else { return }
            withAnimation {
                hasCompletedOnboarding = true
            }
        }
    }
}

#Preview {
    WelcomeView(
        hasCompletedOnboarding: .constant(false)
    )
}
