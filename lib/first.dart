
import 'package:flash_light/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Future<void> main()
async {

  runApp(MaterialApp(
    home: main1(),
    debugShowCheckedModeBanner: false,
  ));
}
class main1 extends StatefulWidget {
  const main1({super.key});

  @override
  State<main1> createState() => _main1State();
}

class _main1State extends State<main1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return FlashlightScreen();
      },));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,

      body: Container(
        alignment: Alignment.center,
       child: Column(mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Container(
             alignment: Alignment.center,
             margin: EdgeInsets.only(top: 20),
             height: 130,
             width: 130,
             decoration: BoxDecoration(image: DecorationImage(image: AssetImage("myassets/flashlight.jpg"),),
               borderRadius: BorderRadius.circular(20),),
           ),
           SizedBox(
             height: 100,
           ),
           Container(margin: EdgeInsets.only(top: 70),child: Text("Flashlight",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),))
         ],
       ),

      ),
    );
  }
}




