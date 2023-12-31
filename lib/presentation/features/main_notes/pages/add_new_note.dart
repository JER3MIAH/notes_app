import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/logic/services/services.dart';
import '../../../../common/common.dart';
import '../../../../data/models/models.dart';
import '../../../../logic/blocs/blocs.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

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
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              leading: state.readOnly
                  ? IconButton(
                      onPressed: () {
                        _noteRepository.addNote(
                          Note(
                            title: _titleController.text,
                            content: _notesController.text,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    )
                  : IconButton(
                      onPressed: () {
                        if (_titleController.text.isEmpty &&
                            _notesController.text.isEmpty) {
                          Navigator.pop(context);
                        } else {
                         _noteRepository.readOnly(state.readOnly);
                        }
                      },
                      icon: const Icon(Icons.check),
                    ),
              title: SizedBox(
                height: 70,
                child: state.readOnly
                    ? Center(child: Text(_titleController.text))
                    : KtextField(
                        hintText: 'title',
                        controller: _titleController,
                      ),
              ),
              actions: [
                state.readOnly
                    ? IconButton(
                        onPressed: () => _noteRepository.notReadOnly(state.readOnly),
                        icon: const Icon(Icons.edit),
                      )
                    : const SizedBox.shrink(),
                kPopUpMenuButton(
                  text: 'Cancel',
                  onTap: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onDoubleTap: () => _noteRepository.readOnly(state.readOnly),
                child: TextFormField(
                  controller: _notesController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration:
                      const InputDecoration(hintText: 'Enter your note'),
                  expands: true,
                  readOnly: state.readOnly,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
