import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/common/utils/page_transition.dart';
import 'package:notes_app/logic/blocs/blocs.dart';
import 'package:notes_app/logic/services/services.dart';
import 'package:notes_app/presentation/features/main_notes/pages/add_new_note.dart';
import 'package:notes_app/presentation/features/settings/settings_page.dart';
import 'package:notes_app/presentation/features/todos/pages/todo_page.dart';

class KbottomNavBar extends StatefulWidget {
  const KbottomNavBar({super.key});

  @override
  State<KbottomNavBar> createState() => _KbottomNavBarState();
}

class _KbottomNavBarState extends State<KbottomNavBar> {
  late NoteRepository _noteRepository;

  @override
  void initState() {
    super.initState();
    final notesBloc = context.read<NotesBloc>();
    _noteRepository = NoteRepository(notesBloc);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (ctx, state) {
        final theme = Theme.of(context).colorScheme;
        if (state.selectedIndices.isNotEmpty) {
          return BottomAppBar(
            color: theme.primary,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    _noteRepository.deleteSelectedNotes(state.selectedIndices);
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
              shape: const CircularNotchedRectangle(),
              height: 70,
              color: theme.secondary,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      bottomToTopNavigation(context, const TodoPage());
                    },
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
                            onTap: () async {
                              Navigator.pop(context);
                              await bottomToTopNavigation(
                                  context, const AddNotePage());
                            }),
                        popUpMenuButton(
                          title: 'New todo',
                          icon: Icons.task,
                          onTap: () {
                            rightToLeftNavigation(context, const TodoPage());
                          },
                        ),
                        popUpMenuButton(
                            title: 'Delete all notes',
                            icon: Icons.delete_forever,
                            onTap: () {
                              _noteRepository.deleteAllNotes();
                            }),
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
