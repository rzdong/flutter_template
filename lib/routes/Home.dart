import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/widgets/MyDrawer.dart';
import '../common/Global.dart';





class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  int _counter = 0;

  DateTime _lastPressedAt;

  TabController _tabController;

  List<String> tabs = [
    '主页',
    '榜单',
    '动态'
  ];

  bool showFloat = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: tabs.length, vsync: this);
    _tabController.addListener((){ 
      BotToast.showText(text: _tabController.index.toString());
      _tabController.index > 0 ? showFloat = false : showFloat = true;
    });
  }


  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    // Navigator.pushNamed(context, "webview");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // extendBody: true,
      appBar: AppBar(
        title: SizedBox(
          width: 180.0,
          child: TabBar(   //生成Tab菜单
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: tabs.map((e){
              return SizedBox(
                height: kToolbarHeight - 2,
                child: Tab(text: e),
              );
            }).toList()
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return InkWell(
              child: Padding(
                padding: const EdgeInsets.all(12.0),

                child: ClipOval(
                  child: Image.asset(
                    "imgs/avatar.jpg",
                    // width: 30,
                  )
                )
              ),
              onTap: () {
                Scaffold.of(context).openDrawer(); 
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      drawer: MyDrawer(),
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt) >
                  Duration(seconds: 1)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressedAt = DateTime.now();
            BotToast.showText(text:"再按一次退出");
            return false;
          }
          return true;
        },
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'You have pushed the button this many times:',
                    ),
                    Text(
                      jsonEncode(Global.profile.toJson()),
                    ),
                    Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.display1,
                    ),
                    FlatButton(
                      child: Text("toWebView"),
                      onPressed: () => Navigator.pushNamed(context, "webview"),
                    ),
                    FlatButton(
                      child: Text("tothemes"),
                      onPressed: () => Navigator.pushNamed(context, "themes"),
                    ),
                    FlatButton(
                      child: Text("tologin"),
                      onPressed: () => Navigator.pushNamed(context, "login"),
                    )
                  ],
                ),
              ),
            Container(
              alignment: Alignment.center,
              child: Text('榜单'),
            ),
            Container(
              alignment: Alignment.center,
              child: Text('动态'),
            )
          ]
        )
        
      ),
      
      floatingActionButton: showFloat ? FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ) :  null// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
