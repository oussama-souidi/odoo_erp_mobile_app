import 'package:flutter/material.dart';
import 'package:mobile_app/modules/achats/components/details_page.dart';
import 'package:mobile_app/modules/achats/components/list_item.dart';

class Achats extends StatelessWidget {
  const Achats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
          mainAxisExtent: 80,
        ),
        itemCount: 3,
        itemBuilder: (context, index) => Container(
          child: ListItem(),
        ),
      ),
    );
  }
}
