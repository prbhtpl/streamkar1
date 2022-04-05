import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:untitled/screens/prifleRelatedScreens/TopUpScreens/paymentRecord.dart';

import '../../../helper/helperFunctions.dart';
class BuyBeans extends StatefulWidget {
  const BuyBeans({Key? key}) : super(key: key);

  @override
  State<BuyBeans> createState() => _BuyBeansState();
}

class _BuyBeansState extends State<BuyBeans> {
  List beansDetails=[];
  int? beans;
  int? bonus;
  int? price;
  var msg;
  bool loading=false;
  Razorpay? razorpay;
  Future PurchaseBeanPost(String payment_id) async {
  EasyLoading.show(status: 'Loading for payment confirmation',);

    var api = Uri.parse("https://vinsta.ggggg.in.net/api/purchaseBeansPost");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {"user_id": id1.toString(),
      "beans":beans.toString(),
      "bouns":bonus.toString(),
      "price":price.toString(),
      "payment_id":payment_id.toString()

    };

    final response = await http.post(api, body: mapeddate);

    var res = await json.decode(response.body);
    print("UploadPosts" + response.body);
    setState(() {

      loading = true;
    });

    try {
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: 'Payment Confirmed');
      }
    } catch (e) {
      print(e);
    }
  }
  Future BeansDetails() async {

    var api = Uri.parse("https://vinsta.ggggg.in.net/api/beansGet");



    final response = await http.get(
      api,
      /* body: mapeddate,*/
    );
    var res = await json.decode(response.body);
     print("UploadPosts2" + response.body);
    setState(() {
      beansDetails = res['response_about'];
      loading = true;
    });

    try {
      if (response.statusCode == 200) {
        loading=true;
      }else{
        Fluttertoast.showToast(msg: 'No Information Found');
      }
    } catch (e) {
      print(e);
    }
  }
  void openCheckOut(int amount){
    var options={
      "key":"rzp_test_tg9piWVpv7ioTj",
      "amount":amount*100.toInt(),
      "timeout": "180",
      "theme.color": "#03be03",
      "currency": "INR",
      "image" : "assets/logo.jpeg",
      "name":"Sample App",
      "Description":"Payment For Buy Beans",
      "prefill": {
        "contact":"7007075948",
        "email":"prbhtpl.pp@gmail.com",
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
  void handlerPaymentSuccess(PaymentSuccessResponse response){
    print("Payment success");
    msg = "SUCCESS: " + response.paymentId.toString();
    Fluttertoast.showToast(msg: msg);

    PurchaseBeanPost(response.paymentId.toString());

  }
  void handlerErrorFailure(PaymentFailureResponse response) {
    msg = "ERROR: " + response.code.toString() + " - " + jsonDecode(response.message.toString())['error']['description'];
    Fluttertoast.showToast(msg:msg);
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    msg = "EXTERNAL_WALLET: " + response.walletName.toString();
    Fluttertoast.showToast(msg:msg);
  }

  @override
  void initState() {
    razorpay= new Razorpay();
    razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
    BeansDetails();
    super.initState();
  }@override
  void dispose() {
    razorpay?.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('Wallet'),backgroundColor: Colors.pinkAccent.shade200,actions: [
        InkWell(onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentRecords()));
        },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: Text(
                  'Record',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                )),
          ),
        )
      ],),

      body:Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [


         loading? Container(
            child: ListView.builder(shrinkWrap: true,itemCount:  beansDetails == null ? 0 : beansDetails.length,itemBuilder: (BuildContext,int index){
              return  SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25,right: 25,top: 5,bottom: 5),
                  child: Column(
                    children: [
                      InkWell(onTap:(){openCheckOut(beansDetails[index]['price']);
                        setState(() {
                          beans=beansDetails[index]['beans'];
                          bonus=beansDetails[index]['bouns'];
                        price = beansDetails[index]['price'];
                        });
print("beans"+beans.toString());
print("bonus"+bonus.toString());
print("price"+price.toString());

                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                          Row(children: [   Image.asset('assets/nuts.png',scale: 8,),Text('${beansDetails[index]['beans']} + ${beansDetails[index]['bouns']}'),],),
                          Container(width: 90,padding: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
                              decoration: BoxDecoration(color: Colors.pinkAccent.shade200,
                                  border: Border.all(
                                    color: Colors.red,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child: Text('${beansDetails[index]['price']}',style: TextStyle(color: Colors.white),)
                          ),
                        ],),
                      ),
                      Divider(thickness: 1,)
                    ],
                  ),
                ),
              );
            }),
          ):Container(child: Center(child: CircularProgressIndicator(),)),
        ],
      ),
    );
  }
}
