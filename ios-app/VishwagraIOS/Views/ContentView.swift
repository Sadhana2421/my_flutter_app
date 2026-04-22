import SwiftUI

struct ContentView: View {
    @State private var showsSplash = true

    var body: some View {
        ZStack {
            TabView {
                ForEach(WebTab.allCases) { tab in
                    WebScreen(title: tab.title, path: tab.path)
                        .tabItem {
                            Label(tab.title, systemImage: tab.systemImage)
                        }
                }
            }
            .tint(.red)

            if showsSplash {
                SplashScreen()
                    .transition(.opacity)
            }
        }
        .task {
            guard showsSplash else { return }

            try? await Task.sleep(nanoseconds: 1_800_000_000)

            await MainActor.run {
                withAnimation(.easeOut(duration: 0.35)) {
                    showsSplash = false
                }
            }
        }
    }
}
