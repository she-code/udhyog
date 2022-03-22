class Press {
  int pressId;
  String pressType;
  String pressName;
  int clientId;
  DateTime createdAt;
  int tankTopTemp;
  var tankLowerTemp;
  String blockTemp;
  var hoseTemp;
  var partCount;
  int timer;
  Press({
    required this.pressId,
    required this.pressType,
    required this.pressName,
    required this.clientId,
    required this.createdAt,
    required this.tankTopTemp,
    required this.tankLowerTemp,
    required this.blockTemp,
    required this.hoseTemp,
    required this.partCount,
    required this.timer,
  });
}

enum pressTypes { SemiAtomic, Atomic }
