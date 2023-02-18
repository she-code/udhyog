import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);
  static String routeName = '/orderDetails';

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Razorpay? _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeed
    print({"Success", response});
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

  Future openCheckout() async {
    var options = {
      'key': 'rzp_test_4Ha2Vn5kKLnYTi',
      'amount': 50000, //in the smallest currency sub-unit.
      'name': 'Acme Corp.',
      'order_id': "order_LHnFHhrsHkLvrJ", // Generate order_id using Orders API
      'description': 'Fine T-Shirt',
      'timeout': 60, // in seconds
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
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        child: Text('click'),
        onPressed: openCheckout,
      )),
    );
  }
}
