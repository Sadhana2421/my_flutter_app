import SwiftUI

struct WebScreen: View {
    @StateObject private var store: WebViewStore
    private let title: String

    init(title: String, path: String) {
        self.title = title
        let targetURL = URL(string: path, relativeTo: AppConfig.baseURL)?.absoluteURL ?? AppConfig.baseURL
        _store = StateObject(wrappedValue: WebViewStore(url: targetURL))
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                WebViewContainer(store: store)
                    .ignoresSafeArea(edges: .bottom)

                if store.isLoading {
                    ProgressView(value: store.estimatedProgress)
                        .progressViewStyle(.linear)
                        .padding(.horizontal)
                        .padding(.top, 8)
                }
            }
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {
                        store.goBack()
                    } label: {
                        Image(systemName: "chevron.backward")
                    }
                    .disabled(!store.canGoBack)

                    Button {
                        store.goForward()
                    } label: {
                        Image(systemName: "chevron.forward")
                    }
                    .disabled(!store.canGoForward)

                    Spacer()

                    Button {
                        store.loadHome()
                    } label: {
                        Image(systemName: "house")
                    }

                    Button {
                        store.reload()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
    }

    private var navigationTitle: String {
        let trimmed = store.pageTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? title : trimmed
    }
}
