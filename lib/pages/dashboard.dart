import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          children: <Widget>[
            DashboardCard(
              icon: Icons.account_circle,
              label: 'Profile',
              description: 'View and update your profile information.',
              onTap: () {
                // Navigate to the profile page
              },
            ),
            DashboardCard(
              icon: Icons.attach_money,
              label: 'Sales',
              description: 'Manage your sales and track performance.',
              onTap: () {
                // Navigate to the sales page
              },
            ),
            DashboardCard(
              icon: Icons.shopping_cart,
              label: 'Purchases',
              description: 'Track and manage your purchase orders.',
              onTap: () {
                // Navigate to the purchases page
              },
            ),
            DashboardCard(
              icon: Icons.inventory,
              label: 'Stock',
              description: 'Monitor and manage your stock levels.',
              onTap: () {
                // Navigate to the stock page
              },
            ),
            DashboardCard(
              icon: Icons.people,
              label: 'Partners',
              description: 'Manage your usiness partners and contacts.',
              onTap: () {
                // Navigate to the partners page
              },
            ),
            DashboardCard(
              icon: Icons.logout,
              label: 'Logout',
              description: 'Sign out from your account.',
              onTap: () {
                // Perform logout
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  final VoidCallback onTap;

  DashboardCard({
    required this.icon,
    required this.label,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 48.0,
                color: Colors.blue,
              ),
              SizedBox(height: 16.0),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
