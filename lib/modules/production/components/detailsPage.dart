import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/production/components/product_item.dart';

import '../../../components/appBar.dart';
import '../../../pages/login_page.dart';

class detailsPage extends StatelessWidget {
  final String name;
  final String product;
  final String date;
  final String etat;
  final String quantity;
  final String bom;

  const detailsPage({super.key, required this.product, required this.quantity, required this.name, required this.date, required this.etat, required this.bom});

  Future<dynamic> fetchProduits() async {

    return odooClient.callKw({
      'model': 'mrp.bom.line',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [["bom_id", '=',bom]],
        'fields': ['product_id','product_qty'],
      },
    });
  }
  Future<dynamic> fetchComponents(String bom_id) async {

    return odooClient.callKw({
      'model': 'mrp.bom.line',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [["bom_id", '=',bom_id]],
        'fields': ['id','product_id','product_qty'],
      },
    });
  }

  Widget buildListItem(Map<String, dynamic> record) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: ProductItem(
        produit: record['product_id'][1].toString(),
        quantity: record['product_qty'].toString(),
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
            title: name,
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
                      'Produit',
                      style: TextStyle(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),

                    TextFormField(
                      readOnly: true,
                      initialValue: product,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15.w),
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),
                    Text(
                      'Quantité',
                      style: TextStyle(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: quantity,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15.w),
                      ),
                    ),
                    SizedBox(
                      height: 90.h,
                    ),
                    Text(
                      'Nomenclature',
                      style: TextStyle(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: bom,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15.w),
                      ),
                    ),
                    SizedBox(
                      height: 90.h,
                    ),
                    Text(
                      'Date planifiée',
                      style: TextStyle(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: date,
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
