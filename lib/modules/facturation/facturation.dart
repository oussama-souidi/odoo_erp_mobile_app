import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/components/appBar.dart';
import 'package:mobile_app/components/navbar.dart';
import 'package:mobile_app/modules/facturation/components/AddFact.dart';
import 'package:mobile_app/modules/facturation/components/list_item.dart';

import 'components/fake_repository.dart';

class Facturation extends StatelessWidget {
  final _data = FakeRepo.data;

  Facturation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(145.h),
          child: const appBar(
            title: "Facturation",
          )),
      drawer: const NavBar(),
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => const AddFact()));
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.h,
              ),
              Text(
                'Factures clients',
                style: TextStyle(fontSize: 55.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20.h,
              ),
              for (var data in _data)
                ListItem(
                  client: data.client,
                  montant: data.montant,
                  refFac: data.refFac,
                  dateFac: data.dateFac,
                  dateEch: data.dateEch,
                  dateLiv: data.dateLiv,
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
      ),
    );
  }
}
