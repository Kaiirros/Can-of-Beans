import 'package:final_project/src/pages/home_page.dart';
import 'package:final_project/src/pages/map_page.dart';
import 'package:final_project/src/pages/settings_page.dart';
import 'package:flutter/material.dart';


class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightGreen,
          primary: Colors.lightGreen,
          secondary: Colors.black,
          background: const Color.fromARGB(255, 38, 38, 38),
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
  _NavigationExampleState createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  
  late int _selectedPageIndex;
  late List<Widget>_pages;
  late PageController _pageController;

  @override
  void initState(){
    super.initState();

    _selectedPageIndex = 0;
    _pages = [
      HomePage(),
      MapPage(),
      SettingsPage()
    ];

    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Spotify Maps', style: TextStyle(color: Colors.white)),
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
        backgroundColor: Colors.black,
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
