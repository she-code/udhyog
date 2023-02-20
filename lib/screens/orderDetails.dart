import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:udhyog/providers/order.dart';
import 'package:udhyog/screens/press_container.dart';

import '../providers/auth.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);
  static String routeName = '/orderDetails';

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Razorpay? _razorpay;
  String? authToken;
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    authToken = Provider.of<Auth>(context, listen: false).token;
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    bool verified;
    // Do something when payment succeed
    print({"Success", response});
    print({"payment Id", response.paymentId});
    print({"signiture", response.signature});
    print({"orderId", response.orderId});
    verified = await Provider.of<OrderProvider>(context, listen: false)
        .verifyOrder(response.orderId!, response.paymentId!,
            response.signature!, authToken!, context);
    if (verified) {
      const snackBar = SnackBar(
        content: Text('Successfully paid'),
        duration: Duration(seconds: 3),
      );
      Navigator.of(context).pushReplacementNamed(PressContainer.routeName);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      print("verified");
    }
    //send this to server
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print({"error", response});
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected

    print({"external", response});
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay!.clear();
  }

  Future openCheckout(String orderId, int amount) async {
    var options = {
      'key': 'rzp_test_4Ha2Vn5kKLnYTi',
      'amount': amount * 100, //in the smallest currency sub-unit.
      'name': 'Acme Corp.',
      'order_id': orderId, // Generate order_id using Orders API
      'description': 'Fine T-Shirt',
      'timeout': 120, // in seconds
      'prefill': {'contact': '9123456789', 'email': 'gaurav.kumar@example.com'}
    };
    try {
      _razorpay!.open(options);
    } catch (e) {
      print({"e", e.toString()});
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> args =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    print(args);
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        child: Text('click'),
        onPressed: () => {openCheckout(args[0], args[1])},
      )),
    );
  }
}
