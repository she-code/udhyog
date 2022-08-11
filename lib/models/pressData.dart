class PressData {
// "entry_id": 21,
//             "TankTopTemp": 28,
//             "TankLowerTemp": 56,
//             "BlockTemp": "3",
//             "HoseTemp": 22,
//             "PartCount": 45,
//             "Timer": 10,
//             "powerConsumption": 18,
//             "createdAt": "2022-07-03T09:07:56.000Z",
//             "updatedAt": "2022-07-03T09:07:56.000Z",
//             "press_id": "U4ABC2022WIPSA1",
//             "company_id": 1
  int entry_id;
  var TankTopTemp;
  var TankLowerTemp;
  var BlockTemp;
  var HoseTemp;
  var PartCount;
  var Timer;
  var powerConsumption;
  var createdAt;
  var press_id;
  var company_id;

  PressData(
      {this.entry_id = 0,
      required this.TankLowerTemp,
      required this.TankTopTemp,
      required this.BlockTemp,
      required this.HoseTemp,
      required this.PartCount,
      required this.Timer,
      this.company_id = 0,
      this.createdAt = '',
      required this.powerConsumption,
      this.press_id = ''});

  factory PressData.fromJson(Map<String, dynamic> json) {
    return PressData(
        press_id: json['press_id'],
        company_id: json['company_id'],
        TankLowerTemp: json['TankLowerTemp'],
        TankTopTemp: json['TankTopTemp'],
        BlockTemp: json['BlockTemp'],
        HoseTemp: json['HoseTemp'],
        PartCount: json['PartCount'],
        powerConsumption: json['powerConsumption'],
        createdAt: json['createdAt'],
        Timer: json['Timer'],
        entry_id: json['entry_id']);
  }
}

class PressDataList {
  final List<PressData> pressDatas;
  PressDataList({
    required this.pressDatas,
  });
  factory PressDataList.fromJson(List<dynamic> parsedJson) {
    List<PressData> pressDatas = [];
    pressDatas = parsedJson.map((i) => PressData.fromJson(i)).toList();
    return new PressDataList(pressDatas: pressDatas);
  }
}
