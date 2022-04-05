// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';


import 'dart:math';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../bottomNavigationBar/bottomNavigation.dart';
import '../../../helper/helperFunctions.dart';


class ApplyToBeAnOfficialTalent extends StatefulWidget {
  const ApplyToBeAnOfficialTalent({Key? key}) : super(key: key);

  @override
  State<ApplyToBeAnOfficialTalent> createState() => _ApplyToBeAnOfficialTalentState();
}
enum addType {
  Self,
  Via_Agency,
  Trusted_3rd_Party
}
enum paymentType {
  Cash,
  Bank,
  Paypal
}
enum joinStremKar {
  Join
}
class _ApplyToBeAnOfficialTalentState extends State<ApplyToBeAnOfficialTalent> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController realname = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController NationalIdNumber = TextEditingController();
  TextEditingController ifsc = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController Accountholdername = TextEditingController();
  TextEditingController Accountnumber = TextEditingController();
  TextEditingController agencyId = TextEditingController();
  addType? _character =addType.Self;
  paymentType? options =paymentType.Cash;
  joinStremKar? join =joinStremKar.Join;
  String addtype = 'Self';
  String JoinStremKar = 'Join';
  String PaymentType = 'Cash';
  final picker = ImagePicker();
  File? NationnalId;
  File? bankFile;
  File? HoldingImage;
  File? SelfTakenImage;
  Future getNationalIdImage(context, ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {setState(() {
      NationnalId = new File(pickedFile.path);
      print(NationnalId!.path);
    });


    }
  }
  Future getBankDetailsImage(context, ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {setState(() {
      bankFile = new File(pickedFile.path);
      print(bankFile!.path);
    });


    }
  }
  Future getHoldingImage(context, ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {setState(() {
      HoldingImage = new File(pickedFile.path);
      print(HoldingImage!.path);
    });


    }
  }
  Future getSelfTakenImage(context, ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {setState(() {
      SelfTakenImage = new File(pickedFile.path);
      print(SelfTakenImage!.path);
    });


    }
  }
  String? countryValue;
  String? stateValue;
  String? cityValue;
  bool visibilitySelectPaymentMethod=true;
  bool visibilityViaAgency=true;
  bool visibilitybankForm=false;
  Future AgencyForm() async {
    EasyLoading.show(status: 'Posting...');
    var uploadUrl =
    Uri.parse("https://vinsta.ggggg.in.net/api/userAgencyform");
    var id1 = await HelperFunctions.getVStarUniqueIdkey();
    var requestMulti = http.MultipartRequest('POST', uploadUrl);
    requestMulti.fields['user_id'] = id1.toString();
    requestMulti.fields['user_name'] = realname.text;
    requestMulti.fields['user_email'] = emailAddress.text;
    requestMulti.fields['mobile'] = number.text;
    requestMulti.fields['country'] = countryValue.toString();
    requestMulti.fields['state'] = stateValue.toString();
    requestMulti.fields['city'] = cityValue.toString();
    requestMulti.fields['address'] = address.text;
    requestMulti.fields['nationalIdno'] =NationalIdNumber.text;
    requestMulti.fields['payreceivetype'] = addtype;
    requestMulti.fields['paymentmethod'] = PaymentType;
    requestMulti.fields['ifsc'] = ifsc.text;
    requestMulti.fields['accountholder'] = Accountholdername.text;
    requestMulti.fields['bankname'] = bankName.text;
    requestMulti.fields['account_no'] =Accountnumber.text;
    requestMulti.fields['agency_id'] = agencyId.text;

      requestMulti.files.add(await http.MultipartFile.fromPath('userphoto', HoldingImage!.path));
      requestMulti.files.add(await http.MultipartFile.fromPath('pancardimg', NationnalId!.path));
      requestMulti.files.add(await http.MultipartFile.fromPath('selfyphoto', SelfTakenImage!.path));
      //requestMulti.files.add(await http.MultipartFile.fromPath('bankimg', bankFile!.path));
      var res=await requestMulti.send();

      if(res.statusCode==200){

        EasyLoading.showSuccess('Posted');
        EasyLoading.dismiss();
        setState(() {
          Navigator.pushReplacement(this.context, MaterialPageRoute(builder: (context)=>BottomNavigation(screenId: 0)));
        });
        print('Upload Data');

      }else{
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: 'Something went wrong upload again');
      }
      print(requestMulti.fields);
      // print(fileName);
      return res.reasonPhrase;


  }

  @override
  void initState() {
     visibilitybankForm=false;
    visibilitySelectPaymentMethod=true;
    visibilityViaAgency=false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 45,leading: IconButton(onPressed: (){Navigator.pop(context);},icon: Icon(CupertinoIcons.left_chevron,color: Colors.black,),),elevation:0.5,title: Text('Official Talent Instruction',style: TextStyle(color: Colors.black),),backgroundColor: Colors.white,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0,right:15 ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(controller: realname,
                decoration: InputDecoration(
                  hintText: '* Enter your real name ',
                ),
              ),SizedBox(height: 10,),
              TextFormField(controller: number,keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '* Enter your mobile/WhatsApp number ',
                ),

              ) ,SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Region',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Column(
                    children: [
                      SelectState(style: GoogleFonts.amiri(),
                        // style: TextStyle(color: Colors.red),
                        onCountryChanged: (value) {
                          setState(() {
                            countryValue = value;
                          });
                        },
                        onStateChanged:(value) {
                          setState(() {
                            stateValue = value;
                          });
                        },
                        onCityChanged:(value) {
                          setState(() {
                            cityValue = value;
                          });
                        },

                      ),
                    /*  InkWell(
                        onTap:(){
                          print('country selected is $countryValue');
                          print('country selected is $stateValue');
                          print('country selected is $cityValue');
                        },
                        child: Text(' Check')
                      )*/
                    ],
                  )
                ],
              ),
              Divider(

                indent: 15,
                endIndent: 15,
              ),SizedBox(height: 10,),
              TextFormField(controller: address,
                decoration: InputDecoration(
                  hintText: '* Enter your address (optional) ',
                ),

              ) ,SizedBox(height: 10,),
              TextFormField(controller: emailAddress,keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: '* Enter your email Address ',
                ),

              ) ,SizedBox(height: 10,),
              TextFormField(controller: NationalIdNumber,
                decoration: InputDecoration(
                  hintText: '* Enter your National ID number ',
                ),

              ) ,SizedBox(height: 10,),
              Text('Application will be rejected if you upload invalid ID#',style: TextStyle(color: Colors.red),),SizedBox(height: 10,),
              InkWell(onTap: (){
                print('love');
                Fluttertoast.showToast(msg: NationnalId.toString());
                getNationalIdImage(context, ImageSource.camera);
              },
                child: Container(height: 200,width: 600, decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.pink.shade50,width: 2
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child:NationnalId==null? Center(child: Column(mainAxisAlignment:MainAxisAlignment.center,children: [
                  Icon(CupertinoIcons.add_circled,color: Colors.pinkAccent,),
                  Text('Click to upload national ID image',style: TextStyle(color: Colors.pinkAccent ),)
                ],
                ),):Image.file(NationnalId!,fit: BoxFit.fitWidth),),
              ),SizedBox(height: 10,),
Text('National Id image sample'),SizedBox(height: 10,),

              Container(
                  height: 200,width: 600, decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.pink.shade50,width: 2
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
                child:Image.asset('assets/pancardSample.jpg'),
              ),SizedBox(height: 10,),
              Text('Upload a photo of yourself holding your ID card'),SizedBox(height: 10,),
              InkWell(onTap: (){
                getHoldingImage(context, ImageSource.camera);
              },
                child: Container(height: 200,width: 600, decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.pink.shade50,width: 2
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                    child:HoldingImage==null?Image.asset('assets/yourselfHolding.png'):Image.file(HoldingImage!,fit: BoxFit.fitWidth)),
              ),SizedBox(height: 10,),
              Text('Upload self-taken photo'),SizedBox(height: 10,),
              InkWell(onTap: (){
                getSelfTakenImage(context, ImageSource.camera);
              },
                child: Container(height: 200,width: 600, decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.pink.shade50,width: 2
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                    child:SelfTakenImage==null?Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/user.png',scale: 2,),
                        Text('Click to upload',style: TextStyle(color: Colors.pinkAccent ))
                      ],
                    ):Image.file(SelfTakenImage!,fit: BoxFit.fitWidth)),
              ),SizedBox(height: 10,),
              Text('Choose how yopu want to paid'),SizedBox(height: 10,),
              Row(
                children: [Text('* ',style: TextStyle(color: Colors.pinkAccent )),
                  Text('Select Payment Receival Type',style: TextStyle(color: Colors.grey )),
                ],
              ),SizedBox(height: 10,),
              RadioButtonsReceivalType(),SizedBox(height: 10,),Visibility(visible: visibilityViaAgency,child: Text('''If you "selected Agency". Your payment will sent to your Agency. Please consult with your agency for details.''',style: TextStyle(color: Colors.grey),)),SizedBox(height: 10,),
              Divider(),SizedBox(height: 10,),Visibility(visible: visibilitySelectPaymentMethod,child: Column(children: [
                Row(
                  children: [Text('* ',style: TextStyle(color: Colors.pinkAccent )),
                    Text('Select Payment Method',style: TextStyle(color: Colors.grey )),
                  ],
                ),SizedBox(height: 10,),
                RadioButtonsPaymentMethod(),SizedBox(height: 10,),
                Visibility(visible: visibilitybankForm,child: BankDetails()),
                Divider(),
              ],)),
            SizedBox(height: 10,),


              Text('No Information Required',style: TextStyle(color: Colors.grey )),SizedBox(height: 10,),
              RadioButtonJoinStreamKarAgency(),SizedBox(height: 10,),
              TextFormField(controller: agencyId,
                decoration: InputDecoration(
                  hintText: '* Enter Agency Id ',
                ),

              ),SizedBox(height: 10,),
              SizedBox(height: 30,),
              Container(
                height: 40,width: MediaQuery.of(context).size.width,decoration: BoxDecoration(color:Colors.pinkAccent ,
                  border: Border.all(
                      color:Colors.pinkAccent,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: TextButton(onPressed: (){
                AgencyForm();
              },child: Text('Apply',style: TextStyle(color: Colors.white),),),
              ),
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
  Widget BankDetails(){
    return Column(children: [
      Text('Enter Payment Receiving Details'),
      SizedBox(
        height: 10,
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(onTap: (){
            print('love');
            Fluttertoast.showToast(msg: bankFile.toString());
            getBankDetailsImage(context, ImageSource.camera);
          },
            child: Container(height: 130,width: 200, decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.pink.shade50,width: 2
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
              child:bankFile==null? Center(child: Column(mainAxisAlignment:MainAxisAlignment.center,children: [
                Icon(CupertinoIcons.add_circled,color: Colors.pinkAccent,),
                Align(alignment: Alignment.center,child: Text('Click to upload bank passbook \nimage or cancelled cheque',style: TextStyle(fontSize: 11,color: Colors.pinkAccent ),))
              ],
              ),):Image.file(bankFile!,fit: BoxFit.fitWidth),),
          ),Image.asset('assets/atmcard.png',scale: 2,)
        ],
      ),
      Form(key: _formKey,
        child: Column(children: [
          TextFormField(controller: ifsc,decoration: InputDecoration(hintText: "* Enter Ifsc Code"),),
          TextFormField(controller: bankName,decoration: InputDecoration(hintText: "* Enter Bank Name"),),
          TextFormField(controller: Accountholdername,decoration: InputDecoration(hintText: "* Enter Account Holder Name"),),
          TextFormField(controller: Accountnumber,decoration: InputDecoration(hintText: "* Enter Account Number"),),


        ]),
      )
    ],);
  }
  Widget RadioButtonsReceivalType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Radio<addType>(activeColor: Colors.green,
              value: addType.Self,
              groupValue: _character,
              onChanged: (addType? value) {
                setState(() {
                  _character = value;
                  addtype = addType.Self.name;
                  visibilitySelectPaymentMethod=true;
                  visibilityViaAgency=false;
                });
                print(addtype);
              },
            ),
            SizedBox(
              width: 1,
            ),
            Text('Self'),

          ],
        ),
        Row(
          children: [
            Radio<addType>(activeColor: Colors.green,
              value: addType.Via_Agency,
              groupValue: _character,
              onChanged: (addType? value) {
                setState(() {visibilitySelectPaymentMethod=false;
                  _character = value;
                  visibilityViaAgency=true;
                  addtype = addType.Via_Agency.name;
                });
                print(addtype);
              },
            ),
            SizedBox(
              width: 1,
            ),
            Text('Via Agency'),
          ],
        ),
      /*  Row(
          children: [
            Radio<addType>(activeColor: Colors.green,
              value: addType.Trusted_3rd_Party,
              groupValue: _character,
              onChanged: (addType? value) {
                setState(() {
                  _character = value;
                  addtype = addType.Trusted_3rd_Party.name;
                });
                print(addtype);
              },
            ),
            SizedBox(
              width: 1,
            ),
            Text('Trusted 3rd Party'),

          ],
        ),*/
      ],
    );
  }
  Widget RadioButtonsPaymentMethod() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Radio<paymentType>(activeColor: Colors.green,
              value: paymentType.Cash,
              groupValue: options,
              onChanged: (paymentType? value) {
                setState(() {visibilitybankForm=false;
                  options = value;
                  PaymentType = paymentType.Cash.name;
                });
                print(PaymentType);
              },
            ),
            SizedBox(
              width: 1,
            ),
            Text('Cash'),

          ],
        ),
        Row(
          children: [
            Radio<paymentType>(activeColor: Colors.green,
              value: paymentType.Bank,
              groupValue: options,
              onChanged: (paymentType? value) {
                setState(() {
                  options = value;
                  visibilitybankForm=true;
                  PaymentType = paymentType.Bank.name;
                });
                print(PaymentType);
              },
            ),
            SizedBox(
              width: 1,
            ),
            Text('Bank'),
          ],
        ),
   /*     Row(
          children: [
            Radio<paymentType>(activeColor: Colors.green,
              value: paymentType.Paypal,
              groupValue: options,
              onChanged: (paymentType? value) {
                setState(() {
                  options = value;
                  PaymentType = paymentType.Paypal.name;
                });
                print(PaymentType);
              },
            ),
            SizedBox(
              width: 1,
            ),
            Text('PayPal'),

          ],
        ),*/
      ],
    );
  }
  Widget RadioButtonJoinStreamKarAgency() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Radio<joinStremKar>(activeColor: Colors.green,
              value: joinStremKar.Join,
              groupValue: join,
              onChanged: (joinStremKar? value) {
                setState(() {
                  join = value;
                  JoinStremKar=joinStremKar.Join.name;
                });
                print(JoinStremKar);
              },
            ),
            SizedBox(
              width: 1,
            ),
            Text('I want to join a V Star agency'),

          ],
        ),

      ],
    );
  }
}
