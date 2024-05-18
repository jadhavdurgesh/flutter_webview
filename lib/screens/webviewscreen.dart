import 'package:flutter/material.dart';
import 'package:flutter_webview/screens/homescreen.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _webViewController;
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
              _isError = false;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _isLoading = false;
              _isError = true;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse("https://nutrahara.com/"));
  }

  void _reloadWebView() {
    setState(() {
      _isError = false;
      _isLoading = true;
    });
    _webViewController.loadRequest(Uri.parse("https://nutrahara.com/"));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        if (await _webViewController.canGoBack()) {
          _webViewController.goBack();
        } else {
          Get.to(() => HomeScreen());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("WebView"),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () async {
                if (await _webViewController.canGoBack()) {
                  _webViewController.goBack();
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () async {
                if (await _webViewController.canGoForward()) {
                  _webViewController.goForward();
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _reloadWebView,
            ),
          ],
        ),
        body: SafeArea(
          bottom: false,
          top: false,
          child: Stack(
            children: [
              WebViewWidget(controller: _webViewController),
              if (_isLoading)
                const Center(child: CircularProgressIndicator()),
              if (_isError)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 48),
                      const Text(
                        'Failed to load the webpage',
                        style: TextStyle(color: Colors.red),
                      ),
                      ElevatedButton(
                        onPressed: _reloadWebView,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
