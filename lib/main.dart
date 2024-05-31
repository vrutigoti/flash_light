

import 'package:flash_light/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';


class FlashlightScreen extends StatefulWidget {
  @override
  _FlashlightScreenState createState() => _FlashlightScreenState();
}

class _FlashlightScreenState extends State<FlashlightScreen> {
  late CameraController _controller;
  late CameraDescription _cameraDescription;
  bool _isFlashlightOn = false;
  bool _isSOSMode = false;
  bool _isStrobeMode = false;
  bool _isFastStrobe = false;
  bool _isSlowStrobe = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    _cameraDescription = cameras.first;
    _controller = CameraController(
      _cameraDescription,
      ResolutionPreset.medium,
    );
    await _controller.initialize();
  }

  Future<void> toggleFlashlight() async {
    if (_controller.value.isInitialized) {
      if (_isFlashlightOn) {
        await _controller.setFlashMode(FlashMode.off);
      } else {
        await _controller.setFlashMode(FlashMode.torch);
      }
      setState(() {
        _isFlashlightOn =!_isFlashlightOn;
      });
    }
  }

  Future<void> createSOS() async {
    if (_controller.value.isInitialized) {
      for (int i = 0; i < 5; i++) {
        await _controller.setFlashMode(FlashMode.torch);
        await Future.delayed(Duration(milliseconds: 400));
        await _controller.setFlashMode(FlashMode.off);
        await Future.delayed(Duration(milliseconds: 400));
      }
    }
  }

  Future<void> createFastStrobe() async {
    if (_controller.value.isInitialized) {
      while (_isFastStrobe) {
        await _controller.setFlashMode(FlashMode.torch);
        await Future.delayed(Duration(milliseconds: 50));
        await _controller.setFlashMode(FlashMode.off);
        await Future.delayed(Duration(milliseconds: 50));
      }
    }
  }

  Future<void> createSlowStrobe() async {
    if (_controller.value.isInitialized) {
      while (_isSlowStrobe) {
        await _controller.setFlashMode(FlashMode.torch);
        await Future.delayed(Duration(milliseconds: 500));
        await _controller.setFlashMode(FlashMode.off);
        await Future.delayed(Duration(milliseconds: 500));
      }
    }
  }

  Future<void> stopStrobe() async {
    setState(() {
      _isFastStrobe = false;
      _isSlowStrobe = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Flashlight'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: () {

            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MyApp();
            },));
          }, icon: Icon(Icons.settings)),
          IconButton(onPressed: () {

          }, icon: Icon(Icons.more_vert_rounded)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

             SizedBox(height: 10,),
            IconButton(onPressed: toggleFlashlight,
            icon: _isFlashlightOn ? Icon(Icons.flashlight_on_outlined,size: 50,color: Colors.yellow.shade700,):
            Icon(Icons.flashlight_off_rounded,size: 50,color: Colors.grey,)),



            InkWell(onTap: createSOS,
              child: Container(
                child: Text("SOS",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.orange),),
              ),
            ),

            InkWell(onTap: () {
              setState(() {
                _isFastStrobe = true;
              });
              createFastStrobe();
            },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 150,
                child: Text("Fast Strobe",style: TextStyle(color: Colors.orange,fontSize: 25,fontWeight: FontWeight.bold),),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(width: 1,color: Colors.white)),
              ),
            ),


            InkWell(onTap: () {
              setState(() {
                _isSlowStrobe = true;
              });
              createSlowStrobe();
            },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 150,
                child: Text("Slow Strobe",style: TextStyle(color: Colors.orange,fontSize: 25,fontWeight: FontWeight.bold),),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(width: 1,color: Colors.white)),
              ),
            ),


        InkWell(onTap: stopStrobe,
                child: Container(
                  child: Text("Stop Strobe 🚫",style: TextStyle(color: Colors.orange,fontSize: 40,fontWeight: FontWeight.bold),),
                ),
              ),
            SizedBox(height: 10,),


          ],
        ),
      ),
    );
  }
}