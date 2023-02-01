import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class order extends StatefulWidget {
  const order({super.key});

  @override
  State<order> createState() => _orderState();
}

class _orderState extends State<order> {
  var _razorpay = Razorpay();
  var amountcontroller = TextEditingController();

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 300,
              width: 200,
              child: TextField(
                controller: amountcontroller,
              ),
            ),
            CupertinoButton(
              child: Text("place Order"),
              onPressed: () {
                print('pressed');
                var options = {
                  'key': 'rzp_test_xvlZZBGCo0SzL0',
                  'amount': (int.parse(amountcontroller.text) * 100)
                      .toString(), //in the smallest currency sub-unit.
                  'name': 'Acme Corp.',
                  // Generate order_id using Orders API
                  'description': 'Fine T-Shirt',
                  'timeout': 300, // in seconds
                  'prefill': {
                    'contact': '9123456789',
                    'email': 'gaurav.kumar@example.com'
                  }
                };
                _razorpay.open(options);
                print('done');
              },
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("payment successful");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("payment failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  // Removes all listeners
}
