class Empty {
  factory Empty._uninstantiable() {
    throw UnsupportedError('class Null cannot be instantiated');
  }

  Map<String, dynamic> toJson() {
    throw UnsupportedError('Empty unsupported toJson');
  }

  @override
  String toString() {
    return 'Empty';
  }
}
