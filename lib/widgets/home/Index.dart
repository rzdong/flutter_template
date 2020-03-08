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
      if (error.toString().contains("TIMEOUT")) {
        BotToast.showText(text:"超时，请重试");
      } else {
        BotToast.showText(text:"加载异常，请重试");
      }
      print(error);
    } finally {
      BotToast.closeAllLoading();
    }

  }

  @override 
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Container(
        color: Colors.grey[200],
        child: RefreshIndicator(
          color: Colors.white,
          onRefresh: _refresh,
          backgroundColor: Theme.of(context).primaryColor,
          child: Scrollbar( // 显示进度条
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 6.0),
              child:  Column( 
                  //动态创建一个List<Widget>  
                  children: [
                    CardItem(card: home?.news ?? null),
                    CardItem(card: home?.popular ?? null),
                    CardItem(card: home?.other ?? null)
                  ]
                ),
              ),
          ),
        ),
      )
      
      
    );
    
    
    
    
  }
}

class CardItem extends StatelessWidget {

  CardItem({
    this.card,
  }): super();
  final HomeCard card;

  String timeformat(int time) {
    var d = new DateTime.fromMillisecondsSinceEpoch(time);
    return d.year.toString() + '-' +
    d.month.toString() + '-' +
    d.day.toString() + 
    ' ' + 
    d.hour.toString() + '-' +
    d.minute.toString() + '-' +
    d.second.toString();
  }


  @override
  Widget build(BuildContext context) {
    if (card == null) {
      return Container();
    }
    dynamic arr = [
      Material(
        child: Ink(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'webview', arguments: 'https://www.baidu.com');
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border( bottom:BorderSide(width: 1,color: Colors.grey[200]) )
              ),
              width: double.infinity,
              height: 44.0,
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(card.title, style: TextStyle(fontSize: 16.0)),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey[500], size: 20,)
                ],
              ),
            ),
          )
        )
      )
    ];

    var other = card.list.asMap().keys.map((i) =>
      Material(
        child: Ink(
          child: InkWell(
            onTap: () {BotToast.showText(text: 'click'+card.title + ': ' +i.toString());},
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: 110.0,
              ),
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 300,
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          card.list[i].title,
                          style: TextStyle(
                            fontWeight: FontWeight.w700, 
                            fontSize: 16
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      ),
                      Container(
                        width: 300,
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          card.list[i].content,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.label, color: Colors.grey[300], size: 16,),
                            Text(card.list[i].tag, style: TextStyle(fontSize: 12.0)),
                            Padding(
                              padding: EdgeInsets.only(left: 12.0),
                              child: Icon(Icons.access_time, color: Colors.grey[300], size: 16,),
                            ),
                            Text(timeformat(card.list[i].createdAt), style: TextStyle(fontSize: 12.0))
                          ]
                        )
                      )
                    ],
                  ),
                  Image.network(
                    card.list[i].picture,
                    width: 60,
                  )
                ],
              ),
              decoration: BoxDecoration(
                border: i+1 != card.list.length ? 
                Border( bottom:BorderSide(width: 1, color: Colors.grey[200])) : 
                Border( bottom:BorderSide(width: 8, color: Colors.grey[200]))
              ),
            )
          )
        )
      )
    ).toList();
    

    arr.addAll(other);
    return Column(
      children: arr,
    );
  }
}