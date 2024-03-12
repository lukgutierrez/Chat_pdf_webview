import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart'
    as webview_flutter_android;

import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class ChatPDF extends StatefulWidget {
  const ChatPDF({super.key});

  @override
  State<ChatPDF> createState() => _MyAppState();
}

class _MyAppState extends State<ChatPDF> {
  late WebViewController _webViewController;
  late PlatformWebViewControllerCreationParams _params;

  @override
  void initState() {
    super.initState();
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      _params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      _params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(_params);

    if (Platform.isAndroid) {
      final myAndroidController = controller.platform
          as webview_flutter_android.AndroidWebViewController;

      myAndroidController.setOnShowFileSelector(_androidFilePicker);
    }

    controller
      ..loadRequest(Uri.parse("https://www.chatpdf.com/"))
      ..clearCache()
      ..clearLocalStorage()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    _webViewController = controller;
  }

  Future<List<String>> _androidFilePicker(
      webview_flutter_android.FileSelectorParams params) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        String filePath = result.files.single.path!;

        List<int> fileBytes = await File(filePath).readAsBytes();

        final file =
            await File.fromUri(Uri.file(filePath)).create(recursive: true);

        await file.writeAsBytes(fileBytes, flush: true);

        return [file.uri.toString()];
      }

      return [];
    } catch (e) {
      return [];
    }
  }

  Future<void> _refresh() async {
    await _webViewController.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WebViewWidget(
        controller: _webViewController,
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.white,
        backgroundColor: Colors.pink,
        child: Icon(
          Icons.replay_outlined,
          color: Colors.white,
        ),
        onPressed: () {
          _refresh();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              40.0), // Ajusta el radio para hacerlo más redondo
        ),
      ),
    );
  }
}
