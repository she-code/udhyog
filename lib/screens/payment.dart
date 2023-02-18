import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udhyog/models/auth.dart';
import 'package:udhyog/providers/order.dart';
import 'package:udhyog/screens/orderDetails.dart';
import 'package:udhyog/widgets/overview.dart';
import 'package:udhyog/screens/press_container.dart';
import 'package:udhyog/widgets/logoHeading.dart';
//import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:udhyog/widgets/userNameHeader.dart';

import '../providers/auth.dart';
import '../providers/press.dart';

class Payment extends StatefulWidget {
  static String routeName = '/payment';
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    final pressId = ModalRoute.of(context)?.settings.arguments as String;
    final pressData =
        Provider.of<PressProvider>(context, listen: false).findByID(pressId);
    final authToken = Provider.of<Auth>(context, listen: false).token;
    // final user = Provider.of<Auth>(context, listen: false).myProfile();
    // print(user);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Payment Summary"),
      //   centerTitle: true,
      //   backgroundColor: Colors.green,
      //   leading: Image.asset(
      //     'assets/images/mainLogo.png',
      //     width: 80,
      //     height: 80,
      //   ),
      // ),
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const LogoHeading(),
            UserNameHeader(),
            const SizedBox(
              height: 20,
            ),
            // Padding(
            //     padding: const EdgeInsets.all(15.0),
            //     child: FutureBuilder<User>(
            //         future:
            //             Provider.of<Auth>(context, listen: false).myProfile(),
            //         builder: (ctx, dataSnapshot) {
            //           if (!dataSnapshot.hasData) {
            //             return CircularProgressIndicator();
            //           } else if (dataSnapshot.hasData) {
            //             return Container(
            //                 width: MediaQuery.of(context).size.width,
            //                 padding: EdgeInsets.all(15),
            //                 decoration: BoxDecoration(
            //                     //color: Colors.white,
            //                     borderRadius: BorderRadius.circular(15),
            //                     gradient: const LinearGradient(
            //                         colors: [
            //                           Color.fromARGB(255, 245, 150, 9),
            //                           Color.fromARGB(255, 255, 160, 64)
            //                         ],
            //                         begin: Alignment.topLeft,
            //                         end: Alignment.bottomRight)),
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     const Text("Payed by"),
            //                     Text(StringUtils.capitalize(
            //                         dataSnapshot.data!.company.toString())),
            //                     Row(
            //                       mainAxisAlignment:
            //                           MainAxisAlignment.spaceEvenly,
            //                       children: [
            //                         Container(
            //                           margin: EdgeInsets.only(right: 10),
            //                           child: Text(
            //                             'Phone Number::',
            //                             style: TextStyle(
            //                                 fontWeight: FontWeight.bold),
            //                           ),
            //                         ),
            //                         Text(StringUtils.capitalize(
            //                             dataSnapshot.data!.address1)),
            //                       ],
            //                     ),
            //                     Row(
            //                       mainAxisAlignment:
            //                           MainAxisAlignment.spaceEvenly,
            //                       children: [
            //                         Container(
            //                           margin: EdgeInsets.only(right: 10),
            //                           child: Text(
            //                             'Address:',
            //                             style: TextStyle(
            //                                 fontWeight: FontWeight.bold),
            //                           ),
            //                         ),
            //                         Text(dataSnapshot.data!.cellNo.toString()),
            //                       ],
            //                     ),
            //                     Row(
            //                       mainAxisAlignment:
            //                           MainAxisAlignment.spaceEvenly,
            //                       children: [
            //                         Container(
            //                           margin: EdgeInsets.only(right: 10),
            //                           child: Text(
            //                             'GST Number::',
            //                             style: TextStyle(
            //                                 fontWeight: FontWeight.bold),
            //                           ),
            //                         ),
            //                         Text(StringUtils.capitalize(
            //                             dataSnapshot.data!.gstNo)),
            //                       ],
            //                     ),
            //                   ],
            //                 ));
            //           } else {
            //             return Text("Error");
            //           }
            //         })),

            Overview(
                pressData.press_name,
                pressData.press_id,
                pressData.location,
                pressData.frequnecy.toString(),
                pressData.static_id,
                pressData.TypeOfPress),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Price Details"),
                        Text("Price ( 1 item )"),
                        Text(
                          "Total Amount",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(" "),
                        Text("500hjklkl0".toString()),
                        Text(899.toString())
                      ],
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                child: Text("Done"),
                onPressed:
                    // openCheckout
                    () {
                  Provider.of<OrderProvider>(context, listen: false)
                      .createOrder(899, authToken!, context);
                  Navigator.of(context)
                      .pushReplacementNamed(OrderDetails.routeName);

                  // Navigator.of(context)
                  //     .pushReplacementNamed(PressContainer.routeName);
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
