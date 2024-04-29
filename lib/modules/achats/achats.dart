import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/components/appBar.dart';
import 'package:mobile_app/components/navbar.dart';
import 'package:mobile_app/modules/achats/components/AddCommand.dart';
import 'package:mobile_app/modules/achats/components/list_item.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import '../../pages/login_page.dart';
import 'components/fake_repository.dart';

class Achats extends StatelessWidget {
  final _data = FakeRepo.data;

  Achats({super.key});

  final odooClient = OdooClient('http://10.0.2.2:8069');

  Future<dynamic> check() async {
    await odooClient.authenticate('demo', username, password);
  }

  Future<dynamic> fetchAchats() async {
    await check();
    return odooClient.callKw({
      'model': 'purchase.order',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [],
        'fields': ['name', 'partner_id', 'date_order', 'amount_total', 'state'],
      },
    });
  }

  Widget buildListItem(Map<String, dynamic> record) {
    return ListItem(
        fournisseur: record['partner_id'][1].toString(),
        montant: record['amount_total'].toString(),
        id: record['name'].toString(),
        date: record['date_order'].toString(),
        etat: record['state'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () {
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.h,
            ),

            /*for (var data in _data)
              ListItem(
                fournisseur: data.fournisseur,
                montant: data.montant,
                id: data.id,
                date: data.date,
                etat: data.etat,
              )*/
            SizedBox(
              height: 1900.h,
              child: FutureBuilder(
                  future: fetchAchats(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      print('4444444444444444444444444444444444444444');
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
    );
  }
}
