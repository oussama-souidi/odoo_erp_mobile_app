import 'package:flutter/material.dart';
import 'package:mobile_app/components/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page'),
    Text('Search Page'),
    Text('Profile Page'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: SizedBox(
        height:60,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 20,),
              label: 'Home',

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 20,),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 20,),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          backgroundColor: const Color(0xff453c67),
          onTap: _onItemTapped,
          unselectedItemColor: Colors.grey[300],
          selectedFontSize: 16,
          unselectedFontSize: 14,
        ),
      ),

      drawer: const NavBar(),
    );
  }
}