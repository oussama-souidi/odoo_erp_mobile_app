import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/components/appBar.dart';
import 'package:mobile_app/components/navbar.dart';
import 'package:mobile_app/modules/ventes/components/AddCommand.dart';
import 'package:mobile_app/modules/ventes/components/list_item.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import '../../pages/login_page.dart';
import 'package:mobile_app/modules/ventes/produits/AddProduct.dart';
import 'components/fake_repository.dart';

class Ventes extends StatelessWidget {
  final _data = FakeRepo.data;

  Ventes({super.key});


  Future<dynamic> fetchVentes() async {

    return odooClient.callKw({
      'model': 'sale.order',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [],
        'fields': ['name', 'partner_id', 'create_date', 'amount_total', 'state'],
      },
    });
  }
  Widget buildListItem(Map<String, dynamic> record) {

    return ListItem(
        client: record['partner_id'][1].toString(),
        montant: record['amount_total'].toString(),
        id: record['name'].toString(),
        date: record['create_date'].toString(),
        etat: record['state'].toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: PreferredSize(
        preferredSize: Size.fromHeight(145.h),
        child: const appBar(title: "Ventes",)
      ),
      drawer: const NavBar(),*/
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () {
            selectedProducts = [];
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddCommand()));
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
                'Devis',
                style: TextStyle(fontSize: 55.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 1900.h,
                child: FutureBuilder(
                    future: fetchVentes(),
                    builder:
                        (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        return
                          ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                final record =
                                snapshot.data[index] as Map<String, dynamic>;
                                return buildListItem(record);
                              });
                      } else {
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return const CircularProgressIndicator();
                      }
                    }),
              ),
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
