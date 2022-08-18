class User {
  int company_id;
  String company;
  String email;
  String city;
  int pin;
  String state;
  String country;
  String address1;
  String? address2;
  String? webpage;
  int cellNo;
  String gst;
  String gstNo;
  late String logo;
  String createdAt;
  String contactPerson;
  User(
      {this.company_id = 0,
      required this.company,
      required this.email,
      required this.city,
      required this.country,
      required this.state,
      required this.address1,
      required this.cellNo,
      required this.pin,
      required this.gst,
      required this.gstNo,
      required this.createdAt,
      this.address2 = '',
      this.webpage = '',
      this.logo = '',
      required this.contactPerson});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        company_id: json["company_id"],
        company: json["company"],
        email: json["email"],
        city: json["city"],
        country: json['country'],
        state: json["state"],
        address1: json["address1"],
        address2: json['address2'],
        webpage: json["webpage"],
        logo: json["logo"],
        cellNo: json["cellNo"],
        pin: json["pin"],
        gst: json["gst"],
        gstNo: json["gstNo"],
        createdAt: json["createdAt"],
        contactPerson: json["contactPerson"]);
  }
}

class UsersList {
  final List<User> users;
  UsersList({required this.users});
  factory UsersList.fromJson(List<dynamic> parsedJson) {
    List<User> users = [];
    users = parsedJson.map((i) => User.fromJson(i)).toList();
    return new UsersList(users: users);
  }
}

// "user": {
//     "company_id": 1,
//     "company": "ABC private limit",
//     "email": "fre@gmail.com",
//     "password": "$2b$10$/Rbqxyy2Sgwf6fuhpcW1UuYvJzhhBFl9lghpMGf2yYFuLy0FcKowe",
//     "city": "rea",
//     "pin": 123,
//     "state": "gui",
//     "country": "indai",
//     "address1": "morbi",
//     "address2": null,
//     "webpage": null,
//     "cellNo": 2147483647,
//     "gst": "yes",
//     "gstNo": "lekr",
//     "contactPerson": "jkjljlk",
//     "logo": "Images\\logo-1655187139928.jpeg",
//     "createdAt": "2022-06-14T06:12:20.000Z",
//     "updatedAt": "2022-06-14T06:12:20.000Z"
//   }
// }