import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/domain/entities/note_state.dart';
import 'package:notes_app/utils/const_keys_app.dart';

import '../bloc/add_edit_note_bloc.dart';

class NoteContentField extends StatelessWidget {
  const NoteContentField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditNoteBloc, AddEditNoteState>(
      buildWhen: (previous, current) => previous.noteContent != current.noteContent,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: state.noteContent,
            key: const Key(ConstWidgetKeysApp.noteFormContentKey),
            enabled: state.noteObject?.state == NoteState.archived ? false : true,
            onChanged: (value) => context.read<AddEditNoteBloc>().add(NoteContentChanged(value)),
            decoration: const InputDecoration(
              labelText: 'Treść notatki',
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.blue),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.blue),
              ),
            ),
            minLines: 5,
            maxLines: 5,
          ),
        );
      },
    );
  }
}
