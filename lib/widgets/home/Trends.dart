import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Trends extends StatefulWidget {
  Trends({
    Key key
  }): super(key: key);

  @override
  TrendsState createState() => TrendsState();
}
class TrendsState extends State<Trends> with AutomaticKeepAliveClientMixin{
  
  @override
  bool get wantKeepAlive => true;

  Future<String> mockNetworkData() async {
    return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
  }

  @override
  void initState() {
    super.initState();
    print('inittrends');
  }

  @override
  void dispose() {
    super.dispose();
    print('distrends');
  }

  @override 
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: FutureBuilder<String>(
        future: mockNetworkData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // 请求已结束
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // 请求失败，显示错误
              return Text("Error: ${snapshot.error}");
            } else {
              // 请求成功，显示数据
              return Text("Contents: ${snapshot.data}");
            }
          } else {
            // 请求未结束，显示loading
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}