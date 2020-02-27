import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {

  MyDrawer({
    Key key,
    @required this.scaffoldKey
  }): super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  MyDrawerState createState() => MyDrawerState();

}

class DrawerItemList {
  DrawerItemList({
    @required this.title,
    @required this.routeName,
  });

  final String title;
  final String routeName;
}


class MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {


  static List<DrawerItemList> _drawerContents = <DrawerItemList>[
    new DrawerItemList(title: '浏览webview', routeName: 'webview'),
    new DrawerItemList(title: '设置主题', routeName: 'themes'),
    new DrawerItemList(title: '去登陆', routeName: 'login'),
    new DrawerItemList(title: '设置语言', routeName: 'language'),
  ];

  void _showNotImplementedMessage(String routeName) {
    // Navigator.pop(context); // Dismiss the drawer.
      Navigator.pushNamed(context, routeName);
  //   widget.scaffoldKey.currentState.showSnackBar(const SnackBar(
  //     content: Text("The drawer's items don't do anything"),
  //   ));
    // return void (String routeName) {
    //   Navigator.pushNamed(context, routeName);
    // };
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "imgs/avatar.jpg",
                        width: 80,
                      ),
                    ),
                  ),
                  Text(
                    "Wendux",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            MediaQuery.removePadding(
              context: context,
              // DrawerHeader consumes top MediaQuery padding.
              removeTop: true,
              child: Expanded(
                child: ListView(
                  dragStartBehavior: DragStartBehavior.down,
                  padding: const EdgeInsets.only(top: 8.0),
                  children: _drawerContents.map<Widget>((DrawerItemList item) {
                    return ListTile(
                      leading: CircleAvatar(child: Text(item.title[0])),
                      title: Text(item.title),
                      onTap: () {
                        _showNotImplementedMessage(item.routeName);
                      },
                    );
                  }).toList(),
                ),
              ),
            )
          ]
        ),
    );
  }
}