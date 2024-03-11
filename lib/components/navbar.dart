import 'package:flutter/material.dart';
import 'package:mobile_app/pages/login_page.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
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
          ListTile(
            leading: const Icon(Icons.home, color: Color(0xff001950),),
            title: const Text('Accueil'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.storefront, color: Color(0xff001950),),
            title: const Text('Magasins'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.attach_money, color: Color(0xff001950),),
            title: const Text('Facturation'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart, color: Color(0xff001950),),
            title: const Text('Ventes'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.payments, color: Color(0xff001950),),
            title: const Text('Achats'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.inventory_2, color: Color(0xff001950),),
            title: const Text('Stock'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.groups, color: Color(0xff001950),),
            title: const Text('Partenaires'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.widgets, color: Color(0xff001950),),
            title: const Text('Articles'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings, color: Color(0xff001950),),
            title: const Text('Paramètres'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.exit_to_app, color: Color(0xff001950),),
            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));},
          ),
        ],
      ),
    );
  }
}