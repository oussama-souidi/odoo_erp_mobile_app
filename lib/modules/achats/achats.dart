import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/components/appBar.dart';
import 'package:mobile_app/components/navbar.dart';
import 'package:mobile_app/modules/achats/components/AddCommand.dart';
import 'package:mobile_app/modules/achats/components/list_item.dart';

import 'components/fake_repository.dart';

class Achats extends StatelessWidget {
  final _data = FakeRepo.data;

  Achats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(145.h),
        child: const appBar(title: "Achats",)
      ),
      drawer: const NavBar(),
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const details_page()));
          },
          backgroundColor: const Color(0xff8c7bc9),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),

          // ...
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var data in _data)
              ListItem(
                fournisseur: data.fournisseur,
                montant: data.montant,
                id: data.id,
                date: data.date,
                etat: data.etat,
              )
            /*GridView.builder(
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
            ),*/
          ],
        ),
      ),
    );
  }
}
