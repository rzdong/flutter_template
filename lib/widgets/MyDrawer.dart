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


class MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {


  static const List<String> _drawerContents = <String>[
    'A', 'B', 'C', 'D', 'E',
  ];

  void _showNotImplementedMessage() {
    Navigator.pop(context); // Dismiss the drawer.
    widget.scaffoldKey.currentState.showSnackBar(const SnackBar(
      content: Text("The drawer's items don't do anything"),
    ));
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
                  children: _drawerContents.map<Widget>((String id) {
                    return ListTile(
                      leading: CircleAvatar(child: Text(id)),
                      title: Text('Drawer item $id'),
                      onTap: _showNotImplementedMessage,
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