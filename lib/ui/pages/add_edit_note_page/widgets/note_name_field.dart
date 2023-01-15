import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/domain/entities/note_state.dart';
import 'package:notes_app/ui/pages/add_edit_note_page/bloc/add_edit_note_bloc.dart';
import 'package:notes_app/utils/const_keys_app.dart';

import '../models/note_name.dart';

class NoteNameField extends StatelessWidget {
  const NoteNameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditNoteBloc, AddEditNoteState>(
      buildWhen: (previous, current) => previous.noteName != current.noteName,
      builder: (context, state) {
        return SizedBox(
          height: 90,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              key: const Key(ConstWidgetKeysApp.noteFormNameKey),
              enabled: state.noteObject?.state == NoteState.archived ? false : true,
              initialValue: state.noteName.value,
              onChanged: (value) => context.read<AddEditNoteBloc>().add(NoteNameChanged(value)),
              decoration: InputDecoration(
                  labelText: 'Nazwa',
                  errorText: state.noteName.invalid
                      ? state.noteName.error == NoteNameValidationError.empty
                          ? 'Pole nie może być puste'
                          : 'Błąd'
                      : null,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.red),
                  )),
            ),
          ),
        );
      },
    );
  }
}
