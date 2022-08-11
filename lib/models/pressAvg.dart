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
  double TankTopTemp;
  double TankLowerTemp;
  double BlockTemp;
  double HoseTemp;
  double PartCount;
  double Timer;
  double powerConsumption;
  //int createdAt;
  // var press_id;
  // var company_id;

  PressAverage(
    // this.entry_id = 0,
    this.TankLowerTemp,
    this.TankTopTemp,
    this.BlockTemp,
    this.HoseTemp,
    this.PartCount,
    this.Timer,
    //this.company_id = 0,
    //this.createdAt = '',
    this.powerConsumption,
    //this.press_id = ''
  );

  // factory PressAverage.fromJson(Map<String, dynamic> json) {
  //   return PressAverage(
  //     //press_id: json['press_id'],
  //     //company_id: json['company_id'],
  //     TankLowerTemp: json['TankLowerTemp'],
  //     TankTopTemp: json['TankTopTemp'],
  //     BlockTemp: json['BlockTemp'],
  //     HoseTemp: json['HoseTemp'],
  //     PartCount: json['PartCount'],
  //     powerConsumption: json['powerConsumption'],
  //     //  createdAt: json['createdAt'],
  //     Timer: json['Timer'],
  //     // entry_id: json['entry_id']
  //   );
}


// class PressAverageList {
//   final List<PressAverage> PressAverages;
//   PressAverageList({
//     required this.PressAverages,
//   });
//   factory PressAverageList.fromJson(List<dynamic> parsedJson) {
//     List<PressAverage> PressAverages = [];
//     PressAverages = parsedJson.map((i) => PressAverage.fromJson(i)).toList();
//     return new PressAverageList(PressAverages: PressAverages);
//   }
// }
