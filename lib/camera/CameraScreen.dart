import 'package:camerademo/data/entity/ImageEntity.dart';
import 'package:camerademo/home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import '../data/db/AppDatabase.dart';

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({Key? key, required this.camera}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: CameraPreview(_controller)),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(onPressed: () async{
                        final image= await  _controller.takePicture();
                        print(image.path.toString());
                        final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
                        final imageDao = database.imageDao;
                        await imageDao.insertImage(ImageEntity(null,image.path));
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context)=>HomeScreen(camera: widget.camera,)));
                      }, child: Text("Capture",style: TextStyle
                        (color: Colors.white),),style: ElevatedButton.styleFrom( shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                        side: BorderSide(color: Colors.black),
                      ),
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        backgroundColor: Colors.blue,
                      ),
                      ),
                    ),
                  ],
                )
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}