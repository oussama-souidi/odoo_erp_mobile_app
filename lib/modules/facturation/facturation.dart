import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/components/appBar.dart';
import 'package:mobile_app/components/navbar.dart';
import 'package:mobile_app/modules/facturation/components/AddFact.dart';
import 'package:mobile_app/modules/facturation/components/AddProduct.dart';
import 'package:mobile_app/modules/facturation/components/list_item.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import '../../pages/login_page.dart';
import 'components/fake_repository.dart';

class Facturation extends StatefulWidget {
  Facturation({super.key});

  @override
  State<Facturation> createState() => _FacturationState();
}

class _FacturationState extends State<Facturation> {
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
        'domain': [['move_type', '=', 'out_invoice']],
        'fields': [
          'id',
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
      client: record['invoice_partner_display_name'] is String ? record['invoice_partner_display_name'] : '',
      montant: record['amount_total_signed'].toString(),
      refFac: record['name'] is String ? record['name'] : '',
      id: record['id'] is String ? record['id'] : '',
      dateFac: record['invoice_date'] is String ? record['invoice_date'] : '',
      dateEch: record['invoice_date_due'] is String ? record['invoice_date_due'] : '',
      dateLiv: record['delivery_date'] is String ? record['delivery_date'] : '',
      etat: record['state'] is String ? record['state'] : '',
    );
  }

  Future<void> _refresh(){
    return Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () async {
            selectedProducts = [];
            final result = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddFact()));
            if (result == true){
              setState(() {});
            }
          },
          backgroundColor: const Color(0xff8c7bc9),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: _refresh,
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

              ],
            ),
          ),
        ),
      ),
    );
  }
}
