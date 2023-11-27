import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/utils/others/utils.dart';
import 'package:notes_app/logic/theme_bloc/theme_bloc.dart';
import 'package:notes_app/logic/theme_bloc/theme_event.dart';
import 'package:notes_app/logic/user_bloc/user_bloc.dart';
import 'package:notes_app/logic/user_bloc/user_state.dart';
import 'package:notes_app/presentation/pages/settings/settings_page.dart';

class Kdrawer extends StatefulWidget {
  const Kdrawer({super.key});

  @override
  State<Kdrawer> createState() => _KdrawerState();
}

class _KdrawerState extends State<Kdrawer> {
  final bool _selected = false;
  bool _dummySwitch = false;
  bool _dummySwitch2 = false;

  toggleTheme() {
    context.read<ThemeBloc>().add(const ToggleThemeEvent());
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Drawer(
          backgroundColor: Theme.of(context).colorScheme.background,
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(state.user.name),
                accountEmail: Text(state.user.name),
                currentAccountPicture: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.background),
                onDetailsPressed: () {
                  // kNavigation(context, const OnlineBackUp());
                },
              ),
              DrawerHeader(
                child: Column(
                  children: [
                    SwitchListTile(
                      value: _dummySwitch,
                      selected: _selected,
                      onChanged: (_) {
                        setState(() {
                          _dummySwitch = !_dummySwitch;
                        });
                      },
                      title: const Text('dummy text'),
                    ),
                    SwitchListTile(
                      value: _dummySwitch2,
                      selected: _selected,
                      onChanged: (value) {
                        setState(() {
                          _dummySwitch2 = !_dummySwitch2;
                        });
                      },
                      title: const Text('dummy text'),
                    ),
                  ],
                ),
              ),
              DrawerHeader(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.menu_book_rounded),
                      title: const Text('Tutorial'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.archive),
                      title: const Text('Archive'),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              DrawerHeader(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Settings'),
                      onTap: () {
                        kNavigation(context, const SettingPage());
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SwitchListTile(
                  title: const Text('dark mode'),
                  value: themeState.isDarkMode,
                  onChanged: (_) {
                    toggleTheme();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
