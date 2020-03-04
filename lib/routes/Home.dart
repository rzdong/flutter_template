
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/widgets/MyDrawer.dart';
import 'package:flutter_template/widgets/home/Index.dart';
import 'package:flutter_template/widgets/home/Ranks.dart';
import 'package:flutter_template/widgets/home/Trends.dart';



class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  DateTime _lastPressedAt;

  TabController _tabController;

  List<MenuItem> tabs = [
    MenuItem(name: '主页', child: Index()),
    MenuItem(name: '榜单', child: Ranks()),
    MenuItem(name: '动态', child: Trends()),
  ];

  bool showFloat = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: tabs.length, vsync: this);
    _tabController.addListener((){
      setState(() {
        showFloat = _tabController.index < 1;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    // setState(() {
    //   _counter++;
    // });
    Navigator.pushNamed(context, "webview");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('build home');
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      // extendBody: true,
      appBar: AppBar(
        elevation: 0.0,
        title: SizedBox(
          width: 190.0,
          child: TabBar(   //生成Tab菜单
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: tabs.map((e){
              return SizedBox(
                height: kToolbarHeight - 3,
                child: Tab(text: e.name),
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
                // Navigator.push(context, MaterialPageRoute(
                //   builder: (context) { return Login(); }
                // ));
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      drawer: MyDrawer(
        scaffoldKey: _scaffoldKey
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (_tabController.index > 0) {
            _tabController.animateTo(0);
            return false;
          } else {
            if (_lastPressedAt == null ||
                DateTime.now().difference(_lastPressedAt) >
                    Duration(seconds: 1)) {
              //两次点击间隔超过1秒则重新计时
              _lastPressedAt = DateTime.now();
              BotToast.showText(text:"再按一次退出");
              return false;
            }
            return true;
          }
        },
        child: TabBarView(
          controller: _tabController,
          children: tabs.asMap().keys.map((index){
              return tabs[index].child;
          }).toList(),
        )
        
      ),
      
      floatingActionButton: showFloat ? FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: '发布动态',
          child: Icon(Icons.add),
        ) :  null
    );
  }
}

class MenuItem {
  MenuItem({
    @required this.name,
    @required this.child
  }): super();
  final String name;
  final Widget child;
}
