import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_app/low.dart';
import 'dart:async';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

// StatelessWidget是不可变的，属性固定
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        // app的主题
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // 注册路由表
        routes: {
          "new_pages":(context)=>NewRouter(),
        },
        home: new RandomWord());
  }
}

class RandomWord extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RandomWordState();
  }
}

class RandomWordState extends State<RandomWord> {
  // 存储单词的数组
  final _suggests = <WordPair>[];

  // 记录是否标记过
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Welcome to flutter"),
        // 标题栏添加按钮
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
        centerTitle: true,
      ),
      // 正文
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        // itemBuilder没调用一次自增1
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          if (index >= _suggests.length) {
            _suggests.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggests[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      // 处理点击事件
      onTap: () {
        // setState()会触发State对象的build方法，以此来刷新UI
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final tiles = _saved.map((pair) {
        return new ListTile(
          title: new Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });
      final divided =
      ListTile.divideTiles(tiles: tiles, context: context).toList();
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Saved Suggestions"),
          centerTitle: true,
          // 标题栏添加按钮
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.list),
                // 按钮添加点击事件
                onPressed: () {
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (context) {
                        // 跳转到新页面
                    return new NewRouter(content : "nihao");
                  }));
                })
          ],
        ),
        body: new ListView(children: divided),
      );
    }));
  }

  Future<String> loadAssets() async{
    return await rootBundle.loadString("assets/config.json");
  }
}



//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//  final String title;
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'hahaha You have click the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ),
//    );
//  }
//}
