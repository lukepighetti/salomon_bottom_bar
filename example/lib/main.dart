import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _selectedTab = _SelectedTab.home;

  void _handleValueTapped(_SelectedTab e) {
    setState(() {
      _selectedTab = e;
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'salomon_bottom_bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("salomon_bottom_bar"),
        ),
        body: Center(
          child: SalomonBottomBar<_SelectedTab>(
            selectedValue: _selectedTab,
            onValueTapped: _handleValueTapped,
            tabs: [
              /// Home
              SBBTab(
                icon: Icon(Icons.home),
                title: "Home",
                color: Colors.purple,
                value: _SelectedTab.home,
              ),

              /// Likes
              SBBTab(
                icon: Icon(Icons.favorite_border),
                title: "Likes",
                color: Colors.pink,
                value: _SelectedTab.likes,
              ),

              /// Search
              SBBTab(
                icon: Icon(Icons.search),
                title: "Search",
                color: Colors.orange,
                value: _SelectedTab.search,
              ),

              /// Profile
              SBBTab(
                icon: Icon(Icons.person),
                title: "Profile",
                color: Colors.teal,
                value: _SelectedTab.profile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _SelectedTab { home, likes, search, profile }
