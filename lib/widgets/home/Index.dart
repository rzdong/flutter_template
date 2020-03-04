import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/common/Git.dart';
import 'package:flutter_template/models/index.dart';

class Index extends StatefulWidget {
  Index({
    Key key
  }): super(key: key);

  @override
  IndexState createState() => IndexState();
}
class IndexState extends State<Index> with AutomaticKeepAliveClientMixin{ //Flutter 三种方式实现页面切换后保持原页面状态 https://www.jianshu.com/p/7d4a028529b9  https://blog.csdn.net/weixin_44941011/article/details/90044642

  @override
  bool get wantKeepAlive => true;

  Home home;

  Future<String> mockNetworkData() async {
    return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
  }

  @override
  void initState() {
    super.initState();
    print('initindex');
    init();
  }

  @override
  void dispose() {
    super.dispose();
    print('disindex');
  }

  Future<Null> _refresh() async {
    await init();
  }

  Future<void> init() async {
    BotToast.showLoading(); //弹出一个加载动画
    try {
      home = await Git().getHome();
      setState(() {
        home = home;
      });
    } catch (error) {
      BotToast.showText(text:"加载异常，请重试");
      print(error);
    } finally {
      BotToast.closeAllLoading();
    }

  }

  @override 
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _refresh,
        backgroundColor: Theme.of(context).primaryColor,
        color: Colors.white70,
        child: Scrollbar( // 显示进度条
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Column( 
                //动态创建一个List<Widget>  
                children: [
                  Text(home.toString()),
                  Text(home.toJson().toString())
                ]
              ),
            ),
          ),
        ),
      ),
    );
    
    
    
    
  }
}

// <Widget>[
//   Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Text(
//           'You have pushed the button this many times:',
//         ),
//         Text(
//           jsonEncode(Global.profile.toJson()),
//         ),
//         Text(
//           '$_counter',
//           style: Theme.of(context).textTheme.display1,
//         ),
//       ],
//     ),
//   ),
//   _tabController.index == 1 ? Ranks() : ,
//   Container(
//     alignment: Alignment.center,
//     child: Text('动态'),
//   )
// ]