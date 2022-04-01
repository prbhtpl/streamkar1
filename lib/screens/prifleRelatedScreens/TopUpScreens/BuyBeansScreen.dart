
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
class BuyBeans extends StatefulWidget {
  const BuyBeans({Key? key}) : super(key: key);

  @override
  State<BuyBeans> createState() => _BuyBeansState();
}

class _BuyBeansState extends State<BuyBeans> {
  Razorpay? razorpay;
  void openCheckOut(){
    var options={
      "key":"rzp_test_tg9piWVpv7ioTj",
      "amount":1*100.toInt(),
      "timeout": "180",
      "theme.color": "#03be03",
      "currency": "INR",
      "image" : "assets/logo.jpeg",
      "name":"Sample App",
      "Description":"Payment For Buy Beans",
      "prefill": {
        "contact":"",
        "email":"",
      },
      "externals":{
        "wallet":["paytm"],
        "":"",
      },


    };
    try{
      razorpay?.open(options);
    }catch(e){print(e.toString());}
  }
  void handlerPaymentSuccess(){
    Fluttertoast.showToast(msg: 'Payment Success');
  }
  void handlerPaymentError(){
    Fluttertoast.showToast(msg: 'Payment Error');
  }
  void handlerPaymentWallet(){
    Fluttertoast.showToast(msg: 'External Wallet');
  }
@override
  void initState() {
    razorpay= new Razorpay();
    razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentError);
    razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerPaymentWallet);

    super.initState();
  }@override
  void dispose() {
    razorpay?.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('Wallet'),backgroundColor: Colors.pinkAccent.shade200,),

      body:Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Account Id: Pal Prabhat'),
          ),
          Divider(),
          Container(
            child: ListView.builder(shrinkWrap: true,itemCount: 5,itemBuilder: (BuildContext,int index){
              return  Padding(
                padding: const EdgeInsets.only(left: 25,right: 25,top: 5,bottom: 5),
                child: Column(
                  children: [
                    InkWell(onTap:(){openCheckOut();},
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                        Row(children: [   Image.asset('assets/nuts.png',scale: 8,),Text('3500+2300'),],),
                        Container(width: 90,padding: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
                            decoration: BoxDecoration(color: Colors.pinkAccent.shade200,
                                border: Border.all(
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Text('${index * 100}',style: TextStyle(color: Colors.white),)
                        ),
                      ],),
                    ),
                    Divider(thickness: 1,)
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
