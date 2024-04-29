import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/achats/achats.dart';
import 'package:mobile_app/components/navbar.dart';
import 'package:mobile_app/pages/login_page.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import '../components/appBar.dart';
import '../modules/facturation/facturation.dart';
import '../modules/ventes/ventes.dart';

final odooClient = OdooClient('http://10.0.2.2:8069');

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _currentPageIndex = 0;
  String appBarText = 'Acceuil';

  void _onNavigationItemSelected(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  static final List<Widget> _widgetOptions = [
    const Text("Home page"),
    const Text("Hedhi Mazelet"),
    const Text("Hata hedhi mazelet"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const Text("Home page"),
      const Text("magasins"),
      Facturation(),
      Ventes(),
      Achats(),
      const Text("stock"),
      const Text("partenaires"),
      const Text("articles"),
      const Text("parametres"),
      const Text("logout"),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(145.h),
            child: appBar(title: appBarText,)
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: const Text('User Account'),
                  accountEmail: const Text('user@gmail.com'),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/pfp.jpg',
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                      ),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xffbda7d1),
                  ),
                ),
                Column(children: [
                  ListTile(
                    leading: const Icon(
                      Icons.home,
                      color: Color(0xff001950),
                    ),
                    title: const Text('Accueil'),
                    onTap: () {
                      _onNavigationItemSelected(0);
                      Navigator.pop(context);
                      appBarText = 'Accueil';
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.storefront,
                      color: Color(0xff001950),
                    ),
                    title: const Text('Magasins'),
                    onTap: () {
                      _onNavigationItemSelected(1);
                      Navigator.pop(context);
                      appBarText = 'Magasins';
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.attach_money,
                      color: Color(0xff001950),
                    ),
                    title: const Text('Facturation'),
                    onTap: () {
                      _onNavigationItemSelected(2);
                      Navigator.pop(context);
                      appBarText = 'Facturation';
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.shopping_cart,
                      color: Color(0xff001950),
                    ),
                    title: const Text('Ventes'),
                    onTap: () {
                      _onNavigationItemSelected(3);
                      Navigator.pop(context);
                      appBarText = 'Ventes';
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.payments,
                      color: Color(0xff001950),
                    ),
                    title: const Text('Achats'),
                    onTap: () {
                      _onNavigationItemSelected(4);
                      Navigator.pop(context);
                      appBarText = 'Achats';
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.inventory_2,
                      color: Color(0xff001950),
                    ),
                    title: const Text('Stock'),
                    onTap: () {
                      _onNavigationItemSelected(5);
                      Navigator.pop(context);
                      appBarText = 'Stock';
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.groups,
                      color: Color(0xff001950),
                    ),
                    title: const Text('Partenaires'),
                    onTap: () {
                      _onNavigationItemSelected(6);
                      Navigator.pop(context);
                      appBarText = 'Partenaires';
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.widgets,
                      color: Color(0xff001950),
                    ),
                    title: const Text('Articles'),
                    onTap: () {
                      _onNavigationItemSelected(7);
                      Navigator.pop(context);
                      appBarText = 'Articles';
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.settings,
                      color: Color(0xff001950),
                    ),
                    title: const Text('Paramètres'),
                    onTap: () {
                      _onNavigationItemSelected(8);
                      Navigator.pop(context);
                      appBarText = 'Accueil';
                    },
                  ),
                  ListTile(
                    title: const Text('Logout'),
                    leading: const Icon(
                      Icons.exit_to_app,
                      color: Color(0xff001950),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                    },
                  ),
                ])
              ],
            ),
          ),
        ),
        body: IndexedStack(
          index: _currentPageIndex,
          children: pages,
        ),
        /*bottomNavigationBar: SizedBox(
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
            unselectedItemColor: Colors.grey.shade400,
            selectedFontSize: 16,
            unselectedFontSize: 14,
          ),
        ),*/
      ),
    );
  }
}
