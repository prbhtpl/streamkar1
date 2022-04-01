import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BuyDiamond extends StatefulWidget {
  const BuyDiamond({Key? key}) : super(key: key);

  @override
  State<BuyDiamond> createState() => _BuyDiamondState();
}

class _BuyDiamondState extends State<BuyDiamond> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent.shade200,
        title: const Text('Balance'),
        toolbarHeight: 40,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              color: Colors.white70,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget> [Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
              children: [
              Image.asset(
                    'assets/nuts.png',
                    scale: 6.5,
              ),
        SizedBox(
          width: 10,
        ),
        Text(
          '0',
          style: TextStyle(fontSize: 18),
        )
        ],
    ),
                Text('Beans Balance',style: TextStyle(color: Colors.grey),)  ],
                ),
                  Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/diamond.png',
                            scale: 8,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '0',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ), Text('Gems Balance',style: TextStyle(color: Colors.grey),)
                    ],
                  ),
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
              Text('Exchange Gems to Beans'),
              Row(children: [Text('10 * ',style: TextStyle(color: Colors.grey)),
    Image.asset(
    'assets/diamond.png',
    scale: 16,
    ),
                Text(' =10',style: TextStyle(color: Colors.grey)),Image.asset(
                  'assets/nuts.png',
                  scale: 15.5,
                )

              ],)
            ],),
            InkWell(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Row(children: [Text('400  ',style: TextStyle(color: Colors.grey)),
                  Image.asset(
                    'assets/nuts.png',
                    scale: 16,
                  ),
                ],),
                Container(width: 120,padding: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
                    decoration: BoxDecoration(color: Colors.pinkAccent.shade200,
                        border: Border.all(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('1000 ',style: TextStyle(color: Colors.white),),
                        Image.asset(
                          'assets/diamond.png',
                          scale: 16,
                        ),
                      ],
                    )
                ),

              ],),
            ),
            Divider(thickness: 1,),
            InkWell(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Row(children: [Text('400  ',style: TextStyle(color: Colors.grey)),
                  Image.asset(
                    'assets/nuts.png',
                    scale: 16,
                  ),
                ],),
                Container(width: 120,padding: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
                    decoration: BoxDecoration(color: Colors.pinkAccent.shade200,
                        border: Border.all(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('1000 ',style: TextStyle(color: Colors.white),),
                        Image.asset(
                          'assets/diamond.png',
                          scale: 16,
                        ),
                      ],
                    )
                ),

              ],),
            ),
            Divider(thickness: 1,),
            InkWell(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Row(children: [Text('400  ',style: TextStyle(color: Colors.grey)),
                  Image.asset(
                    'assets/nuts.png',
                    scale: 16,
                  ),
                ],),
                Container(width: 120,padding: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
                    decoration: BoxDecoration(color: Colors.pinkAccent.shade200,
                        border: Border.all(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('1000 ',style: TextStyle(color: Colors.white),),
                        Image.asset(
                          'assets/diamond.png',
                          scale: 16,
                        ),
                      ],
                    )
                ),

              ],),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              color: Colors.white70,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget> [
                  Text('What is the Gem Balance',style: TextStyle(color: Colors.pinkAccent),),
                  Text("⚈ Gems can be exchange for gold beans, used to buy gifts"),
                  Text("⚈ Gems can be settled in cash"),

                  Text("⚈ Provide, operate, and maintain our website"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
