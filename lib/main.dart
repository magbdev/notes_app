import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/domain/repositories/notes_repository.dart';
import 'package:notes_app/ui/pages/notes_page/bloc/notes_list_bloc.dart';
import 'package:notes_app/ui/pages/notes_page/notes_screen.dart';

import 'injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => NotesListBloc(getIt<NotesRepository>())..add(NotesFetched()),
        child: NotesScreen(),
      ),
    );
  }
}
