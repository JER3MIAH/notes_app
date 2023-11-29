import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/common/utils/page_transition.dart';
import 'package:notes_app/data/models/models.dart';
import 'package:notes_app/logic/blocs/blocs.dart';
import 'package:notes_app/presentation/features/main_notes/pages/add_new_note.dart';
import 'package:notes_app/presentation/features/settings/settings_page.dart';

class KbottomNavBar extends StatelessWidget {
  const KbottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    deleteNotes() {
      context.read<NotesBloc>().add(DeleteSelectedNotesEvent());
    }

    deleteNotesFromDatabase(List<Note> selectedNotes) {
      context
          .read<NotesBloc>()
          .add(DeleteSelectedUserNotesEvent(selectedNotes: selectedNotes));
    }

    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        final theme = Theme.of(context).colorScheme;
        if (state.selectedIndices.isNotEmpty) {
          final selectedNotes = state.selectedIndices.map((index) {
            return state.notes[index];
          }).toList();

          return BottomAppBar(
            color: theme.primary,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    deleteNotes();
                    deleteNotesFromDatabase(selectedNotes);
                  },
                  icon: const Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          );
        } else {
          return SafeArea(
            child: BottomAppBar(
              height: 70,
              color: theme.secondary,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.format_list_bulleted),
                  ),
                  const Spacer(),
                  PopupMenuButton(
                    color: Theme.of(context).colorScheme.primary,
                    // offset: Offset(0, 50),
                    iconSize: 30,
                    icon: const Icon(Icons.more_horiz),
                    itemBuilder: (context) {
                      return [
                        popUpMenuButton(
                            title: 'New note',
                            icon: Icons.add,
                            onTap: () {
                              bottomToTopNavigation(
                                  context, const AddNotePage());
                            }),
                        popUpMenuButton(
                            title: 'New todo', icon: Icons.task, onTap: () {}),
                        popUpMenuButton(
                            title: 'Delete all notes',
                            icon: Icons.delete_forever,
                            onTap: () {}),
                        popUpMenuButton(
                            title: 'Settings',
                            icon: Icons.settings,
                            onTap: () {
                              bottomToTopNavigation(
                                context,
                                const SettingPage(),
                              );
                            }),
                      ];
                    },
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }

  PopupMenuItem<dynamic> popUpMenuButton({
    required String title,
    required IconData icon,
    required void Function()? onTap,
  }) {
    return PopupMenuItem(
      onTap: onTap,
      child: ListTile(
        titleTextStyle: const TextStyle(color: Colors.white),
        iconColor: Colors.white,
        leading: Icon(icon),
        title: Text(title),
      ),
    );
  }
}
