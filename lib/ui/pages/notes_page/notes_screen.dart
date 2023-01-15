import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/domain/repositories/notes_repository.dart';
import 'package:notes_app/ui/pages/add_edit_note_page/add_edit_note_screen.dart';
import 'package:notes_app/ui/pages/notes_page/models/notes_state_filter.dart';
import 'package:notes_app/ui/pages/notes_page/widgets/add_new_note_fab_button.dart';
import 'package:notes_app/ui/pages/notes_page/widgets/date_picker.dart';
import 'package:notes_app/ui/pages/notes_page/widgets/note_list_item.dart';
import 'package:notes_app/ui/pages/notes_page/widgets/search_text_field.dart';
import 'package:notes_app/ui/pages/notes_page/widgets/state_picker.dart';
import 'package:notes_app/utils/const_keys_app.dart';

import '../../../injection.dart';
import '../add_edit_note_page/bloc/add_edit_note_bloc.dart';
import 'bloc/notes_list_bloc.dart';

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Twoje notatki'),
      ),
      floatingActionButton: AddNewNoteFabButton(),
      body: BlocBuilder<NotesListBloc, NotesListState>(
        builder: (context, state) {
          if (state.notes.isEmpty) {
            if (state.status == NotesStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == NotesStatus.initial) {
              return const SizedBox();
            } else if (state.status == NotesStatus.failure) {
              return const Text('Błąd');
            }
          }
          return Column(
            children: [
              SafeArea(
                child: Column(children: [SearchTextField(), DatePicker(), StatePicker()]),
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: ((context, index) => NoteListItem(note: state.filteredNotes[index])),
                  itemCount: state.filteredNotes.length,
                  separatorBuilder: (context, index) => Container(
                    color: Colors.black87,
                    height: 1,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
