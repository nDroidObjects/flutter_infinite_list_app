
import 'package:flutter/material.dart';

class MyApp3 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage3(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage3 extends StatefulWidget {
  MyHomePage3({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState3 createState() => new _MyHomePageState3();
}

class _MyHomePageState3 extends State<MyHomePage3> {

  int present = 0;
  int perPage = 15;

  final originalItems = List<String>.generate(10000, (i) => "Item $i");
  var items = List<String>();


  @override
  void initState() {
    super.initState();
    setState(() {
      items.addAll(originalItems.getRange(present, present + perPage));
      present = present + perPage;
    });
  }

  void loadMore() {
    setState(() {
      if((present + perPage )> originalItems.length) {
        items.addAll(
            originalItems.getRange(present, originalItems.length));
      } else {
        items.addAll(
            originalItems.getRange(present, present + perPage));
      }
      present = present + perPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels ==
              scrollInfo.metrics.maxScrollExtent) {
            loadMore();
          }
        },
        child: ListView.builder(
          itemCount: (present <= originalItems.length) ? items.length + 1 : items.length,
          itemBuilder: (context, index) {
            return (index == items.length ) ?
            Container(
              color: Colors.greenAccent,
              child: FlatButton(
                child: Text("Load More"),
                onPressed: () {
                  loadMore();
                },
              ),
            )
                :
            ListTile(
              title: Text('${items[index]}'),
            );
          },
        ),
      ),
    );
  }
}