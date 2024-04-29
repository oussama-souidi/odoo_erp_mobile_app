import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/components/appBar.dart';
import 'package:mobile_app/components/navbar.dart';
import 'package:mobile_app/modules/facturation/components/AddFact.dart';
import 'package:mobile_app/modules/facturation/components/list_item.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import '../../pages/login_page.dart';
import 'components/fake_repository.dart';

class Facturation extends StatelessWidget {
  Facturation({super.key});

  final odooClient = OdooClient('http://10.0.2.2:8069');

  Future<dynamic> check() async {
    await odooClient.authenticate('demo', username, password);
  }

  Future<dynamic> fetchFact() async {
    await check();
    return odooClient.callKw({
      'model': 'account.move',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [],
        'fields': [
          'name',
          'invoice_partner_display_name',
          'invoice_date',
          'invoice_date_due',
          'delivery_date',
          'amount_total_signed',
          'state'
        ],
      },
    });
  }

  Widget buildListItem(Map<String, dynamic> record) {
    return ListItem(
      client: record['invoice_partner_display_name'].toString(),
      montant: record['amount_total_signed'].toString(),
      refFac: record['name'].toString(),
      dateFac: record['invoice_date'].toString(),
      dateEch: record['invoice_date_due'].toString(),
      dateLiv: record['delivery_date'].toString(),
      etat: record['state'].toString(),
    );
  }

  final _data = FakeRepo.data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddFact()));
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
              SizedBox(
                height: 1900.h,
                child: FutureBuilder(
                    future: fetchFact(),
                    builder:
                        (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        print('3333333333333333333333333333');
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
              /*for (var data in _data)
                ListItem(
                  client: data.client,
                  montant: data.montant,
                  refFac: data.refFac,
                  dateFac: data.dateFac,
                  dateEch: data.dateEch,
                  dateLiv: data.dateLiv,
                  etat: data.etat,
                )*/
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
