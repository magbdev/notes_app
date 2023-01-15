import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/notes_list_bloc.dart';

class DatePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesListBloc, NotesListState>(
      buildWhen: (previous, current) => previous.datePicked != current.datePicked,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            showDatePicker(context: context, initialDate: state.datePicked, firstDate: DateTime(2000), lastDate: DateTime(2100))
                .then((value) => value != null ? context.read<NotesListBloc>().add(NotesPickedDateChanged(value)) : null);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(border: Border.all()),
            child: Row(
              children: [const Icon(Icons.calendar_today), Text(DateFormat('yyyy-MM-dd').format(state.datePicked))],
            ),
          ),
        );
      },
    );
  }
}
