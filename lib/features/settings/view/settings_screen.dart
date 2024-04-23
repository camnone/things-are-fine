import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thingsarefine/blocs/theme_cubit/theme_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:thingsarefine/features/history/bloc/history_bloc.dart';
import 'package:thingsarefine/features/settings/widgets/settings_action_card.dart';
import 'package:thingsarefine/features/settings/widgets/settings_toggle_card.dart';

import 'package:thingsarefine/ui/snack_bar.dart';
import 'package:thingsarefine/ui/ui.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  _launchURL() async {
    final Uri url = Uri.parse('https://geeksbureau.com/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: [
        const CustomAppBar(title: "Settings"),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 16,
          ),
        ),
        SliverToBoxAdapter(
            child: SettingsToggleCard(
          title: "Dark mode",
          value: context.watch<ThemeCubit>().state.isDark ? true : false,
          onChanged: (value) {
            _setTheme(context, value);
          },
        )),
        SliverToBoxAdapter(
            child: SettingsToggleCard(
          title: "Notific ations",
          value: false,
          onChanged: (value) async {},
        )),
        SliverToBoxAdapter(
          child: SettingsToggleCard(
            title: "Allow Analytics",
            value: false,
            onChanged: (value) async {},
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 16,
          ),
        ),
        SliverToBoxAdapter(
          child: SettingsActionCard(
              iconColor: Colors.red,
              title: "Clear history",
              icon: Icons.delete_outline_sharp,
              onTap: () async {
                context.read<HistoryBloc>().add(DeleteAllHistory());
                await SnackBarService(
                  context,
                  message: "The history has been cleared",
                  closeIcon: true,
                  error: false,
                ).showSnackBar();

                //await ChatRepository().clearHistory();
              }),
        ),
        SliverToBoxAdapter(
          child: SettingsActionCard(
            iconColor: theme.hintColor,
            title: "Support",
            icon: Icons.message_sharp,
            onTap: () async {
              await _launchURL();
            },
          ),
        ),
      ],
    );
  }

  void _setTheme(BuildContext context, bool value) {
    context
        .read<ThemeCubit>()
        .setTheme(value ? Brightness.dark : Brightness.light);
  }
}
