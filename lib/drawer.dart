import 'package:flutter/material.dart';
import 'Login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget mydrawer(context) {
  return SafeArea(
    child: Container(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 128.0,
              height: 128.0,
              margin: const EdgeInsets.only(top: 24.0, bottom: 30.0),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
              child: Image.asset('assets/Farmer.png'),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.account_circle_rounded),
              title: Text('Profile'),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(FontAwesomeIcons.wheatAwnCircleExclamation),
              title: Text('Pest Control'),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.note_alt_sharp),
              title: Text('Plants History'),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Loginpage()),
                  (Route<dynamic> route) => false,
                );
              },
              leading: Icon(Icons.login_sharp),
              title: Text('Logout'),
            ),
            Spacer(),
            DefaultTextStyle(
              style: TextStyle(fontSize: 12, color: Colors.white54),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Terms of Service | Privacy Policy'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
