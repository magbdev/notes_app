enum NoteState {
  newEdit(0),
  approved(1),
  archived(2);

  const NoteState(this.value);
  final int value;

  factory NoteState.fromValue(int value) {
    return values.firstWhere((e) => e.value == value);
  }

  @override
  String toString() {
    switch (this) {
      case NoteState.newEdit:
        return 'Nowe/edytowane';
      case NoteState.approved:
        return 'Zatwierdzone';
      case NoteState.archived:
        return 'Zarchiwizowane';
    }
  }
}
