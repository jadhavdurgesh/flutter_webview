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

  final webViewController = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(Uri.parse("https://nutrahara.com/"));

  bool _isError = false;

  void _reloadWebView() {
    setState(() {
      _isError = false;
    });
    webViewController.loadRequest(Uri.parse("https://nutrahara.com/"));
  }

  void _handleWebResourceError(WebResourceError error) {
    setState(() {
      _isError = true;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
          Get.to(() => HomeScreen());
      },
      child: Scaffold(
        appBar: AppBar(
        title: Text("WebView"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _reloadWebView,
          ),
        ],
      ),
        body: SafeArea(
          bottom: false,
          top: false,
          child: WebViewWidget(controller: webViewController,)),
      floatingActionButton: FloatingActionButton(
        onPressed: _reloadWebView,
        child: Icon(Icons.refresh),
      ),
      ),
    );
  }
}