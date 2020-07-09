class Service {
  final String mib;
  final String function;
  final Function precondition;

  Service(
    this.mib,
    this.function,
    this.precondition,
  );

  @override
  String toString() {
    return "$mib";
  }
}
