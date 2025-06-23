import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StreamlitView extends StatefulWidget {
  const StreamlitView({super.key});

  @override
  State<StreamlitView> createState() => _StreamlitViewState();
}

class _StreamlitViewState extends State<StreamlitView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) => debugPrint("Page started: $url"),
          onPageFinished: (url) => debugPrint("Page finished: $url"),
          onWebResourceError: (error) => debugPrint("WebView error: ${error.description}"),
        ),
      )
      ..loadRequest(Uri.parse('https://kucing.streamlit.app/')); // Ganti ke URL Streamlit kamu
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Streamlit App")),
      body: WebViewWidget(controller: controller),
    );
  }
}
