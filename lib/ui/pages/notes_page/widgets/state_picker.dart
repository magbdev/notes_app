import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/ui/pages/notes_page/bloc/notes_list_bloc.dart';

import '../models/notes_state_filter.dart';

class StatePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesListBloc, NotesListState>(
      buildWhen: (previous, current) => previous.stateFilter != current.stateFilter,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          decoration: BoxDecoration(border: Border.all()),
          child: DropdownButton<NotesStateFilter>(
            items: NotesStateFilter.values.map<DropdownMenuItem<NotesStateFilter>>((NotesStateFilter value) {
              return DropdownMenuItem<NotesStateFilter>(
                value: value,
                child: Text(
                  value.toString(),
                  style: const TextStyle(fontSize: 14),
                ),
              );
            }).toList(),
            value: state.stateFilter,
            onChanged: (value) => context.read<NotesListBloc>().add(NotesStateFilterChanged(value!)),
            underline: const SizedBox(),
            isExpanded: true,
          ),
        );
      },
    );
  }
}
