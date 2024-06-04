import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:mobile_app/modules/stock/components/product_item.dart';

import '../../../components/appBar.dart';
import '../../../pages/login_page.dart';

class detailsPage extends StatelessWidget {
  final String name;
  final String id;

  const detailsPage({super.key, required this.name, required this.id});

  Future<dynamic> fetchProduits() async {

    return odooClient.callKw({
      'model': 'stock.quant',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ['location_id', '=', id]
        ],
        'fields': ['id', 'product_id', 'reserved_quantity','inventory_quantity_auto_apply'],
      },
    });
  }

  Widget buildListItem(Map<String, dynamic> record) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: ProductItem(
        produit:
            record['product_id'][1].toString(),
        inventoryQuantity: record['reserved_quantity'].toString(),
        reserverQuantity: record['inventory_quantity_auto_apply'].toString(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(145.h),
          child: appBar(
            title: id,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 65.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    Text(
                      'Nom de l\'emplacement',
                      style: TextStyle(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),

                    TextFormField(
                      readOnly: true,
                      initialValue: name,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15.w),
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    Text(
                      'Emplacement parent',
                      style: TextStyle(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: id,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15.w),
                      ),
                    ),
                    SizedBox(
                      height: 90.h,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 65.w),
                    child: Text(
                      'Produits',
                      style: TextStyle(
                          fontSize: 55.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: 20.h,
                  ),
                  FutureBuilder(
                      future: fetchProduits(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          return SizedBox(
                            height: 1000.h,
                            child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  final record = snapshot.data[index]
                                      as Map<String, dynamic>;
                                  return buildListItem(record);
                                }),
                          );
                        } else {
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          return const CircularProgressIndicator();
                        }
                      }),
                ],
              ),
            ],
          ),
        ));
  }
}
