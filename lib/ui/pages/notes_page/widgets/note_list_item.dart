import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/domain/entities/note.dart';
import 'package:notes_app/domain/entities/note_state.dart';
import 'package:notes_app/ui/pages/notes_page/bloc/notes_list_bloc.dart';

import '../../../../domain/repositories/notes_repository.dart';
import '../../../../injection.dart';
import '../../add_edit_note_page/add_edit_note_screen.dart';
import '../../add_edit_note_page/bloc/add_edit_note_bloc.dart';

class NoteListItem extends StatelessWidget {
  final Note note;

  const NoteListItem({super.key, required this.note});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => BlocProvider(
                    create: (context) => AddEditNoteBloc(note, getIt<NotesRepository>()),
                    child: AddEditNoteScreen(),
                  )))),
      child: Container(
        color: getItemColor(),
        child: ListTile(
          title: Text(
            note.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(DateFormat('yyyy-MM-dd hh:mm').format(note.date)),
          trailing: note.state != NoteState.archived
              ? IconButton(
                  icon: const Icon(Icons.archive),
                  onPressed: () => showArchiveDialog(context),
                )
              : const SizedBox(),
        ),
      ),
    );
  }

  Color getItemColor() {
    switch (note.state) {
      case NoteState.newEdit:
        return Colors.blue[300]!;
      case NoteState.approved:
        return Colors.green[300]!;
      case NoteState.archived:
        return Colors.red[300]!;
    }
  }

  void showArchiveDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Anuluj"),
      onPressed: () => Navigator.pop(context),
    );
    Widget continueButton = TextButton(
      child: const Text("Archiwizuj"),
      onPressed: () {
        context.read<NotesListBloc>().add(NoteArchived(note.id));
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Potwierdzenie"),
      content: const Text("Czy na pewno chcesz zarchiwizować notatkę ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => alert,
    );
  }
}
