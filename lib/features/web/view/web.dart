// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thingsarefine/repositories/app/app_repository.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage()
class WebScreen extends StatefulWidget {
  const WebScreen({super.key});

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  late final WebViewController controller;
  final String url =
      GetIt.I<AppRepository>().getValue(GetIt.I<AppRepository>().link)!;
  var progressPercentage = 0;

  Future<void> _load(url) async {
    controller
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (error) async {
            log(error.errorCode.toString());

            if (error.errorCode == -9 && error.url != null) {
              await controller.loadRequest(Uri.parse(error.url!));
            }
          },
          onPageStarted: (url) {
            setState(
              () {
                progressPercentage = 0;
              },
            );
          },
          onProgress: (progress) {
            setState(() {
              progressPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              progressPercentage = 100;
            });
          },
        ),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('SnackBar', onMessageReceived: (message) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message.message)));
      });
  }

  @override
  void initState() {
    controller = WebViewController()..loadRequest(Uri.parse(url));
    _load(url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Text(""),
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);

                    if (await controller.canGoBack()) {
                      await controller.goBack();
                    } else {
                      messenger.showSnackBar(
                        const SnackBar(
                          content: Text("No Back history Found"),
                        ),
                      );
                    }
                    return;
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                IconButton(
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);

                    if (await controller.canGoForward()) {
                      await controller.goForward();
                    } else {
                      messenger.showSnackBar(
                        const SnackBar(
                          content: Text("No Forward history Found"),
                        ),
                      );
                    }
                    return;
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
                IconButton(
                    onPressed: () {
                      controller.reload();
                    },
                    icon: const Icon(Icons.replay_outlined))
              ],
            )
          ],
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: controller),
            if (progressPercentage < 100)
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor),
                child: Center(
                  child: CircularProgressIndicator(
                    value: progressPercentage / 100,
                  ),
                ),
              )
          ],
        ));
  }
}
