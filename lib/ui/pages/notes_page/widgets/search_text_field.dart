import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/notes_list_bloc.dart';

class SearchTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesListBloc, NotesListState>(
      buildWhen: (previous, current) => false,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Szukaj',
            ),
            initialValue: state.searchValue,
            onChanged: (value) => context.read<NotesListBloc>().add(NotesSearchValueChanged(value)),
          ),
        );
      },
    );
  }
}
