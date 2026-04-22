import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.97, green: 0.19, blue: 0.20),
                    Color(red: 0.52, green: 0.05, blue: 0.08)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 18) {
                ZStack {
                    Circle()
                        .fill(.white.opacity(0.16))
                        .frame(width: 128, height: 128)

                    Circle()
                        .stroke(.white.opacity(0.28), lineWidth: 1)
                        .frame(width: 144, height: 144)

                    Image(systemName: "graduationcap.fill")
                        .font(.system(size: 46, weight: .semibold))
                        .foregroundStyle(.white)
                }

                VStack(spacing: 6) {
                    Text(AppConfig.splashTitle)
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)

                    Text(AppConfig.splashSubtitle)
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.82))
                }

                ProgressView()
                    .tint(.white)
                    .padding(.top, 8)
            }
            .padding(28)
        }
    }
}
