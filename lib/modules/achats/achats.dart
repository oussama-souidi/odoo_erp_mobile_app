import 'package:flutter/material.dart';
import 'package:mobile_app/components/navbar.dart';
import 'package:mobile_app/modules/achats/components/details_page.dart';
import 'package:mobile_app/modules/achats/components/list_item.dart';

import 'components/fake_repository.dart';

class Achats extends StatelessWidget {
  final _data = FakeRepo.data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Achats"),),
      drawer: NavBar(),
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => details_page()));
          },
          backgroundColor: const Color(0xff8c7bc9),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),

          // ...
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 80,
        ),
        itemCount: _data.length,
        itemBuilder: (context, index) => Container(
          child: ListItem(
            fournisseur: _data[index].fournisseur,
            montant: _data[index].montant,
            id: _data[index].id,
            date: _data[index].date,
            etat: _data[index].etat,
          ),
        ),
      ),
    );
  }
}
