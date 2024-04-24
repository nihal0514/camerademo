import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camerademo/camera/CameraScreen.dart';
import 'package:camerademo/camera/PreviewImageScreen.dart';
import 'package:flutter/material.dart';

import '../data/db/AppDatabase.dart';
import '../data/entity/ImageEntity.dart';

class HomeScreen extends StatefulWidget {
  final CameraDescription camera;

  const HomeScreen({super.key,required this.camera});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<ImageEntity> images= [];

  @override
  void initState() {
    super.initState();
    initializeAllImages();
  }
  void initializeAllImages()async{
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final imagesDao = database.imageDao;
    imagesDao.getAllImages().then((value) => {
      images= value
    });
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("Camera App"),
      ),
      body: Column(
        children: [
          images.isEmpty? Expanded(child: Center(child: Text('You dont have any image. Please add',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))):Expanded(child: cameraList()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (BuildContext context)=>CameraScreen(camera: widget.camera,)));
      },icon: Icon(Icons.add), label: Text("Add Image"),),
    );
  }
  Widget cameraList(){
    return ListView.builder(
      itemCount: images.length,
        itemBuilder: (context,index){
        return Card(
          child: InkWell(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (BuildContext context)=>PreviewImageScreen(imagePath: images[index].imagePath)));

            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
                Text("Image ${index}",style: TextStyle(fontSize: 20),),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.file(File(images[index].imagePath),width: 120,height: 120,),
                )
                ]
            ),
          ),
        );

        });
  }
}
