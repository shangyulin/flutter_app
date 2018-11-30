import 'package:flutter/material.dart';
import 'package:flutter_app/third.dart';

class NewRouter extends StatefulWidget {
  String content;
  NewRouter({Key key, this.content}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new NewRouterPager();
  }
}

class NewRouterPager extends State<NewRouter> {
  int count = 0;
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "First Page",
      home: new Scaffold(
        // 标题栏的信息
        appBar: new AppBar(
          title: new Text("First Page"),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.list),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return new ImageRouter();
                  }));
                }
            )
          ],
          centerTitle: true,
        ),
        // 正文垂直居中
        body: Center(
          child: Column(
            children: <Widget>[
              Text(
                widget.content,
                style: _biggerFont,
              ),
              Text("$count", style: _biggerFont)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: IncreaseNumber,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void IncreaseNumber() {
    // 刷新状态，会重新调用build
    setState(() {
      count++;
    });
  }
}
