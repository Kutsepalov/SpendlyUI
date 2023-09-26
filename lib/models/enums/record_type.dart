enum RecordType {
  income('INCOME', 'Income'),
  expense('EXPENSE', 'Expense'),
  transfer('TRANSFER', 'Transfer');

  const RecordType(this.name, this.displayName);

  static RecordType getByName(String name) {
    return RecordType.values.firstWhere((element) => element.name == name,
        orElse: () => throw 'There is no type \'$name\' for record');
  }

  final String name;
  final String displayName;
}
