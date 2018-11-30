import 'package:flutter/material.dart';

class ImageRouter extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ImageRouterImpl();
  }

}

class ImageRouterImpl extends State<ImageRouter>{

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Third Activity",
      home: Scaffold(
        appBar: new AppBar(
          title: new Text("Third Activity"),
          centerTitle: true,
        ),
        body: new DecoratedBox(decoration: new BoxDecoration(
          image: new DecorationImage(image: new AssetImage('asstes/dog.jpg'))
        ))
      ),
    );
  }

}