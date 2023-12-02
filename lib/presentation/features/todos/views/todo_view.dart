import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/common/common.dart';
import 'package:notes_app/logic/blocs/blocs.dart';
import 'package:notes_app/logic/repositories/repos.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  late TodoRepository todoRepository;

  @override
  void initState() {
    super.initState();
    final todoBloc = context.read<TodoBloc>();
    todoRepository = TodoRepository(todoBloc);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.todos.length,
          itemBuilder: (ctx, index) {
            final todo = state.todos[index];
            return Row(
              children: [
                Checkbox(
                  shape: const CircleBorder(),
                  checkColor: theme.background,
                  value: todo.isCompleted,
                  onChanged: (value) {
                    value = todo.isCompleted;
                    todoRepository.toggleCompletion(index);
                  },
                ),
                Expanded(
                  child: KtodoTile(
                    title: todo.title,
                    onRemove: () {
                      todoRepository.removeTodo(todo);
                    },
                    toggleCompletion: () {
                      todoRepository.toggleCompletion(index);
                    },
                    isCompleted: todo.isCompleted,
                    tileColor: todo.isCompleted
                        ? const Color(0xff61677A)
                        : theme.secondary,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
