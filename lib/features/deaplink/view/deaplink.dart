import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thingsarefine/repositories/app/app_repository.dart';
import 'package:thingsarefine/router/router.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class DeaplinkScreen extends StatefulWidget {
  const DeaplinkScreen({super.key});

  @override
  State<DeaplinkScreen> createState() => _DeaplinkScreenState();
}

class _DeaplinkScreenState extends State<DeaplinkScreen> {
  Future<void> _launchDeepLink() async {
    try {
      String url = GetIt.I<AppRepository>()
          .getValue(GetIt.I<AppRepository>().redirectUrl)!;
      await GetIt.I<AppRepository>()
          .clearKeyValue(GetIt.I<AppRepository>().redirectUrl);
      await launchUrl(Uri.parse(url));
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    _launchDeepLink();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 8,
            ),
            const Text(
              textAlign: TextAlign.center,
              "Redirect to the app",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 8,
            ),
            const SizedBox(
              width: 320,
              child: Text(
                  textAlign: TextAlign.center,
                  "If the redirect did not occur, then check if you have the application installed",
                  style: TextStyle(fontSize: 12)),
            ),
            const SizedBox(
              height: 8,
            ),
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
                ),
                backgroundColor: MaterialStatePropertyAll<Color>(
                  Theme.of(context).hoverColor,
                ),
              ),
              child: const Text("Back"),
              onPressed: () {
                context.pushRoute(const WebRoute());
              },
            ),
          ],
        ),
      ),
    );
  }
}
