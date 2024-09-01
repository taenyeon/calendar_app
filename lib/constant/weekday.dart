enum Weekday {
  sunday('SUN', 7),
  monday('MON', 1),
  tuesday('TUE', 2),
  wednesday('WED', 3),
  thursday('THU', 4),
  friday('FRI', 5),
  saturday('SAT', 6),
  ;

  const Weekday(this.code, this.value);

  final String code;
  final int value;

  factory Weekday.getByValue(int value) {
    return Weekday.values.firstWhere(
      (weekday) => weekday.value == value,
    );
  }
}
