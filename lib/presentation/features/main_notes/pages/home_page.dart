import 'package:flutter/material.dart';
import 'package:notes_app/presentation/features/main_notes/views/app_bar.dart';
import 'package:notes_app/presentation/features/main_notes/views/bottom_nav_bar.dart';
import 'package:notes_app/presentation/features/main_notes/views/notes_view.dart';
import 'package:notes_app/presentation/features/main_notes/views/drawer.dart';
import '../../../../common/common.dart';
import '../views/fab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exitConfirmed = await showExitConfirmationDialog(context);
        return exitConfirmed;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: const KappBar(),
        body: const NotesView(),
        bottomNavigationBar: const KbottomNavBar(),
        drawer: const Kdrawer(),
        floatingActionButton: const Kfab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
