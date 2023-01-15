import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../bloc/add_edit_note_bloc.dart';

class SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditNoteBloc, AddEditNoteState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: state.status.isValid
                ? () {
                    context.read<AddEditNoteBloc>().add(SaveNotePressed());
                    Navigator.pop(context);
                  }
                : null,
            child: Text('Zapisz'),
          ),
        );
      },
    );
  }
}
