import 'package:final_project/src/pages/home_page.dart';
import 'package:final_project/src/pages/map_page.dart';
import 'package:final_project/src/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer' as developer;

StreamController<bool> streamController = StreamController<bool>();

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  //DARK MODE TOGGLE BOOLEAN
  static var darkMode = false;



  @override
  Widget build(BuildContext context) {
        return MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.lightGreen,
              primary: Colors.lightGreen,
              secondary: Colors.black,
              background: const Color.fromARGB(255, 36, 36, 36),
              tertiary: Colors.grey,
              ),
            ),
          home: const NavigationExample(),
        );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  // ignore: library_private_types_in_public_api
  NavigationExampleState createState() => NavigationExampleState();
}

class NavigationExampleState extends State<NavigationExample> {
  
  late int _selectedPageIndex;
  late List<Widget>_pages;
  late PageController _pageController;
  bool darkMode = false;

  @override
  void initState(){
    super.initState();

    _selectedPageIndex = 0;
    _pages = [
      HomePage(streamController.stream),
      const MapPage(),
      SettingsPage(toDarkMode),
    ];

    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  void toDarkMode(){
    setState(() {
      developer.log("state");
      darkMode = !darkMode;
    });
    streamController.add(darkMode);
  }


  bool getTheme(){
    return darkMode;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (darkMode ?  Colors.black : Colors.white),
      appBar: AppBar(
        backgroundColor: (darkMode ?  Colors.black : Colors.white),
        title: darkMode ? const Text('sMaps', style: TextStyle(color: Colors.white)) : const Text('Spotify Maps', style: TextStyle(color: Colors.black)),
      ),
      body: PageView(
        controller: _pageController,

        //This parameter is to prevent the user from scrolling between pages
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        backgroundColor: (darkMode ?  Colors.black : Colors.white),
        selectedItemColor: Colors.lightGreen,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: _selectedPageIndex,
        onTap: (selectedPageIndex) {
          setState(() {
            _selectedPageIndex = selectedPageIndex;
            _pageController.jumpToPage(selectedPageIndex);
          });
        },
        
      ),
    );
  }
}
