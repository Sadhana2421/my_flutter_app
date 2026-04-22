import Combine
import SwiftUI
import WebKit

final class WebViewStore: ObservableObject {
    static let sharedProcessPool = WKProcessPool()

    @Published var pageTitle = AppConfig.appName
    @Published var isLoading = false
    @Published var estimatedProgress = 0.0
    @Published var canGoBack = false
    @Published var canGoForward = false

    let initialURL: URL
    let webView: WKWebView

    private var titleObserver: NSKeyValueObservation?
    private var progressObserver: NSKeyValueObservation?
    private var backObserver: NSKeyValueObservation?
    private var forwardObserver: NSKeyValueObservation?
    private var loadingObserver: NSKeyValueObservation?

    init(url: URL) {
        self.initialURL = url

        let configuration = WKWebViewConfiguration()
        configuration.processPool = Self.sharedProcessPool
        configuration.websiteDataStore = .default()
        configuration.allowsInlineMediaPlayback = true
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.keyboardDismissMode = .onDrag
        self.webView = webView

        observeWebView()
        loadHome()
    }

    func loadHome() {
        load(url: initialURL)
    }

    func load(path: String) {
        guard let url = URL(string: path, relativeTo: AppConfig.baseURL)?.absoluteURL else {
            return
        }

        load(url: url)
    }

    func load(url: URL) {
        webView.load(URLRequest(url: url))
    }

    func reload() {
        webView.reload()
    }

    func goBack() {
        guard webView.canGoBack else { return }
        webView.goBack()
    }

    func goForward() {
        guard webView.canGoForward else { return }
        webView.goForward()
    }

    private func observeWebView() {
        titleObserver = webView.observe(\.title, options: [.initial, .new]) { [weak self] webView, _ in
            DispatchQueue.main.async {
                self?.pageTitle = webView.title?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false
                    ? webView.title ?? AppConfig.appName
                    : AppConfig.appName
            }
        }

        progressObserver = webView.observe(\.estimatedProgress, options: [.initial, .new]) { [weak self] webView, _ in
            DispatchQueue.main.async {
                self?.estimatedProgress = webView.estimatedProgress
            }
        }

        backObserver = webView.observe(\.canGoBack, options: [.initial, .new]) { [weak self] webView, _ in
            DispatchQueue.main.async {
                self?.canGoBack = webView.canGoBack
            }
        }

        forwardObserver = webView.observe(\.canGoForward, options: [.initial, .new]) { [weak self] webView, _ in
            DispatchQueue.main.async {
                self?.canGoForward = webView.canGoForward
            }
        }

        loadingObserver = webView.observe(\.isLoading, options: [.initial, .new]) { [weak self] webView, _ in
            DispatchQueue.main.async {
                self?.isLoading = webView.isLoading
            }
        }
    }
}
