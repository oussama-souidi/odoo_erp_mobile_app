import 'package:flutter/material.dart';
import 'package:mobile_app/modules/achats/achats.dart';
import 'package:mobile_app/modules/achats/components/details_page.dart';
import 'package:mobile_app/components/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = [
    Scaffold(
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => details_page()));
          },
          backgroundColor: const Color(0xff8c7bc9),
          child: const Icon(Icons.add, color: Colors.white,),

          // ...
        ),
      ),

      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 70,
        ),
        itemCount: 1,
        itemBuilder: (context, index) => Container(
          decoration: const BoxDecoration(
            border: Border(
              //bottom: BorderSide(color: Colors.grey, width: 1.0),
              top: BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),
          child: Achats(),
        ),
      ),
    ),
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
        height: 60,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 20,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 20,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 20,
              ),
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
