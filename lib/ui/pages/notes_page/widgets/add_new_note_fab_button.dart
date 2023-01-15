import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repositories/notes_repository.dart';
import '../../../../injection.dart';
import '../../../../utils/const_keys_app.dart';
import '../../add_edit_note_page/add_edit_note_screen.dart';
import '../../add_edit_note_page/bloc/add_edit_note_bloc.dart';

class AddNewNoteFabButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      key: const Key(ConstWidgetKeysApp.buttonAddNoteKey),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => BlocProvider(
                      create: (context) => AddEditNoteBloc(null, getIt<NotesRepository>()),
                      child: AddEditNoteScreen(),
                    ))));
      },
      child: const Icon(Icons.add),
    );
  }
}
