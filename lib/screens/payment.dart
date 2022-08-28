import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udhyog/models/auth.dart';
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
  // late Razorpay _razorpay;
  // @override
  // void initState() {
  //   super.initState();
  //   _razorpay = Razorpay();
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  //   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  // }

  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   // Do something when payment succeed
  //   print({"Success", response});
  // }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   // Do something when payment fails
  //   print({"error", response});
  // }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   // Do something when an external wallet is selected

  //   print({"external", response});
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _razorpay.clear();
  // }

  // void openCheckout() {
  //   var options = {
  //     'key': 'rzp_test_ovopv6bm1rGf6q',
  //     'amount': 50000, //in the smallest currency sub-unit.
  //     'name': 'Acme Corp.',
  //     'order_id': "order_Jz7Ab06IlRURcP", // Generate order_id using Orders API
  //     'description': 'Fine T-Shirt',
  //     'timeout': 60, // in seconds
  //     'prefill': {'contact': '9123456789', 'email': 'gaurav.kumar@example.com'}
  //   };
  //   try {
  //     _razorpay.open(options);
  //   } catch (e) {
  //     print({"e", e.toString()});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final pressId = ModalRoute.of(context)?.settings.arguments as String;
    final pressData =
        Provider.of<PressProvider>(context, listen: false).findByID(pressId);
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
                  Navigator.of(context)
                      .pushReplacementNamed(PressContainer.routeName);
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
