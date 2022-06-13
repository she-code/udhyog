class Press {
  String press_id;
  String TypeOfPress;
  String press_name;
  int company_id;
  String createdAt;
  int frequnecy;
  String hotspot;
  String hots_password;
  String location;
  String static_id;
  late List<dynamic> details;

  // var tankTopTemp;
  // var tankLowerTemp;
  // var blockTemp;
  // var hoseTemp;
  // var partCount;
  //int timer;
  Press(
      {required this.press_id,
      required this.TypeOfPress,
      required this.press_name,
      required this.company_id,
      required this.createdAt,
      required this.frequnecy,
      required this.hotspot,
      required this.hots_password,
      required this.location,
      required this.static_id,
      this.details = const []
      //     required this.dynamic_id
      //     // required this.tankTopTemp,
      //     // required this.tankLowerTemp,
      //     // required this.blockTemp,
      //     // required this.hoseTemp,
      //     // required this.partCount,
      //     // required this.timer,
      });

  factory Press.fromJson(Map<String, dynamic> json) {
    return Press(
        press_id: json['press_id'],
        company_id: json['company_id'],
        press_name: json['press_name'],
        frequnecy: json['frequency'],
        hotspot: json['hotspot'],
        hots_password: json['hots_password'],
        location: json['location'],
        static_id: json['static_id'],
        createdAt: json['createdAt'],
        TypeOfPress: json['TypeOfPress'],
        details: json['details']);
  }
//   }
//   static Map<String,dynamic> getJsonData(){
//     return <String,dynamic>{
//        "press_id":press_id,
//    "TypeOfPress":TypeOfPress,
//    "press_name":press_name,
//   "company_id": company_id,
//  "createdAt": createdAt,
//  "frequnecy":frequnecy,
//   "hotspot": hotspot,
//    "hots_password":hots_password,
//   "location": location,
//  "static_id":  static_id,

//     };
//   }
}

class PressList {
  final List<Press> presses;
  PressList({
    required this.presses,
  });
  factory PressList.fromJson(List<dynamic> parsedJson) {
    List<Press> presses = [];
    presses = parsedJson.map((i) => Press.fromJson(i)).toList();
    return new PressList(presses: presses);
  }
}

enum pressTypes { SemiAtomic, Atomic }
