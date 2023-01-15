import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/ui/pages/add_edit_note_page/bloc/add_edit_note_bloc.dart';
import 'package:notes_app/ui/pages/add_edit_note_page/widgets/note_content_field.dart';
import 'package:notes_app/ui/pages/add_edit_note_page/widgets/note_info_fields.dart';
import 'package:notes_app/ui/pages/add_edit_note_page/widgets/note_name_field.dart';
import 'package:notes_app/ui/pages/add_edit_note_page/widgets/save_button.dart';

class AddEditNoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notatka')),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(children: [
        NoteNameField(),
        NoteContentField(),
        NoteInfoFields(),
        SaveButton(),
      ]))),
    );
  }
}
