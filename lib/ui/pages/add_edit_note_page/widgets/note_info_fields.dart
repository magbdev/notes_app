import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/add_edit_note_bloc.dart';

class NoteInfoFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditNoteBloc, AddEditNoteState>(
      buildWhen: (previous, current) => false,
      builder: (context, state) {
        return state.noteObject != null
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text('Data dodania:'),
                        const SizedBox(width: 5),
                        Text(
                          DateFormat('yyyy-MM-dd hh:mm').format(state.noteObject!.date),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text('Stan:'),
                        const SizedBox(width: 5),
                        Text(
                          state.noteObject!.state.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              )
            : const SizedBox();
      },
    );
  }
}
