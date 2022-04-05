import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../../helper/helperFunctions.dart';

class PaymentRecords extends StatefulWidget {
  const PaymentRecords({Key? key}) : super(key: key);

  @override
  State<PaymentRecords> createState() => _PaymentRecordsState();
}

class _PaymentRecordsState extends State<PaymentRecords> {
  bool loading = false;
  List paymentHistory = [];
  Future GetPaymentHistory() async {
    var api = Uri.parse("https://vinsta.ggggg.in.net/api/userPurchaseBeans");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    Map mapeddate = {
      "user_id": id1.toString(),
    };

    final response = await http.post(api, body: mapeddate);

    var res = await json.decode(response.body);
    print("UploadPosts" + response.body);
    setState(() {
      paymentHistory = res['response_Purchase'];
      loading = true;
    });

    try {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Payment Confirmed');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    GetPaymentHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payments History'),
        toolbarHeight: 40,
        elevation: 0.5,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: paymentHistory == null ? 0 : paymentHistory.length,
          itemBuilder: (BuildContext, int index) {
            return ListTile(
              title:Column(children: [
                Row(
                  children: [Text('beans:  '),
                    Text('${paymentHistory[index]['beans']}'),
                  ],
                ),
                Row(
                  children: [Text('bouns:  '),
                    Text(
                      '${paymentHistory[index]['bouns']}',
                    ),
                  ],
                ),
                Row(
                  children: [Text('price:  '),
                    Text(
                      '${paymentHistory[index]['price'].toString()}',
                    ),
                  ],
                )
              ]),
              trailing:  Text(paymentHistory[index]['user_code']),
              subtitle:Text( paymentHistory[index]['user_name'].toString()),
            );
          }),
    );
  }
}
