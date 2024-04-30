import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thingsarefine/repositories/app/init_app_repositroy.dart';
import 'package:thingsarefine/router/router.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class InternetScreen extends StatefulWidget {
  const InternetScreen({super.key});

  @override
  State<InternetScreen> createState() => _InternetScreenState();
}

class _InternetScreenState extends State<InternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              height: 120,
              "assets/no-conn.svg",
              colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
              semanticsLabel: 'A red up arrow',
            ),
            const SizedBox(
              height: 8,
            ),
            const Text("Check your internet connection"),
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
              child: const Text("Restart"),
              onPressed: () {
                GetIt.I.unregister<InitAppRepository>();
                context.replaceRoute(const LoaderRoute());
              },
            ),
          ],
        ),
      ),
    );
  }
}
