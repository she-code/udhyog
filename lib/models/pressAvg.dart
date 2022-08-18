class PressAverage {
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
  //int entry_id;
  var TankTopTemp;
  var TankLowerTemp;
  var BlockTemp;
  var HoseTemp;
  var PartCount;
  var Timer;
  var powerConsumption;
  String date;
  // var createdAt;
  // var press_id;
  // var company_id;

  PressAverage(
      {
      // this.entry_id = 0,
      required this.TankTopTemp,
      required this.TankLowerTemp,
      required this.BlockTemp,
      required this.HoseTemp,
      required this.PartCount,
      required this.Timer,
      // this.company_id = 0,
      // this.createdAt = '',
      required this.powerConsumption,
      required this.date
      //this.createdAt
      //this.press_id = ''
      });

  factory PressAverage.fromJson(Map<String, dynamic> json) {
    return PressAverage(
        //press_id: json['press_id'],
        //company_id: json['company_id'],
        TankTopTemp: json['TankTopTemp'],
        TankLowerTemp: json['TankLowerTemp'],
        BlockTemp: json['BlockTemp'],
        HoseTemp: json['HoseTemp'],
        PartCount: json['PartCount'],
        powerConsumption: json['powerConsumption'],
        //  createdAt: json['createdAt'],
        Timer: json['Timer'],
        date: json['date']
        // entry_id: json['entry_id']
        );
  }
}

class PressAverageList {
  final List<PressAverage> PressAverages;
  PressAverageList({
    required this.PressAverages,
  });
  factory PressAverageList.fromJson(List<dynamic> parsedJson) {
    List<PressAverage> PressAverages = [];
    PressAverages = parsedJson.map((i) => PressAverage.fromJson(i)).toList();
    return new PressAverageList(PressAverages: PressAverages);
  }
}
