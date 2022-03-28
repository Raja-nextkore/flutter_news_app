import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticalPage extends StatefulWidget {
  final String blogUrl;
  const ArticalPage({Key? key, required this.blogUrl}) : super(key: key);

  @override
  State<ArticalPage> createState() => _ArticalPageState();
}

class _ArticalPageState extends State<ArticalPage> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: RichText(
          text: TextSpan(
              text: ' Flutter ',
              style: GoogleFonts.rakkas(
                textStyle: const TextStyle(
                    color: Colors.white,
                    letterSpacing: .8,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    backgroundColor: Colors.black),
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'News',
                  style: GoogleFonts.abrilFatface(
                    textStyle: const TextStyle(
                        color: Colors.blue,
                        letterSpacing: .8,
                        backgroundColor: Colors.white),
                  ),
                ),
              ]),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.blogUrl,
          onWebViewCreated: (WebViewController webViewController) {
            _completer.complete(webViewController);
          },
        ),
      ),
    );
  }
}
