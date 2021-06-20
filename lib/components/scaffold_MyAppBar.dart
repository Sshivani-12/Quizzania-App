import 'package:flutter/material.dart';
import 'package:rait_online_portal/constants.dart';

class MyAppBar extends StatelessWidget {
  MyAppBar({@required this.label, @required this.containerContent});
  final String label;
  final Container containerContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Row(
          children: <Widget>[
            Expanded(
              child: Image.asset(
                'images/RAIT_logo.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              flex: 2,
              child: Text(
                label,
                style: kAppBarTitleTextStyle,
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: containerContent,
      ),
    );
  }
}
