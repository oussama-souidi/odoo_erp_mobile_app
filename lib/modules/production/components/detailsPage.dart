import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/production/components/product_item.dart';
import 'package:mobile_app/modules/production/components/workorder_item.dart';

import '../../../components/appBar.dart';
import '../../../pages/login_page.dart';

class detailsPage extends StatefulWidget {
  final String name;
  final String product;
  final String date;
  final String etat;
  final String quantity;
  final String bom;

  const detailsPage(
      {super.key,
      required this.product,
      required this.quantity,
      required this.name,
      required this.date,
      required this.etat,
      required this.bom});

  @override
  State<detailsPage> createState() => _detailsPageState();
}

class _detailsPageState extends State<detailsPage> {
  Future<dynamic> fetchProduits() async {
    return odooClient.callKw({
      'model': 'mrp.bom.line',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ["bom_id", '=', widget.bom]
        ],
        'fields': ['product_id', 'product_qty'],
      },
    });
  }

  Future<dynamic> fetchWorkOrders() async {
    return odooClient.callKw({
      'model': 'mrp.workorder',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          ["product_id", '=', widget.product],
          ['product_id', '!=', null]
        ],
        'fields': ['name', 'qty_remaining', 'state'],
      },
    });
  }

  Widget buildListItem(Map<String, dynamic> record) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: ProductItem(
        produit: record['product_id'] == null ? '.' : record['product_id'][1].toString(),
        quantity: record['product_qty'].toString(),
      ),
    );
  }

  Widget buildListItemWO(Map<String, dynamic> record) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: WorkOrderItem(
        product: widget.product,
        quantity: record['qty_remaining'].toString(),
        name: record['name'].toString(),
        state: record['state'].toString(),
      ),
    );
  }

  Widget components() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        SizedBox(
          height: 20.h,
        ),
        FutureBuilder(
            future: fetchProduits(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: 1000.h,
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        final record =
                            snapshot.data[index] as Map<String, dynamic>;
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
    );
  }

  Widget workorder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        SizedBox(
          height: 20.h,
        ),
        FutureBuilder(
            future: fetchWorkOrders(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: 1000.h,
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        final record =
                            snapshot.data[index] as Map<String, dynamic>;
                        return buildListItemWO(record);
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
    );
  }

  bool showProducts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(145.h),
          child: appBar(
            title: widget.name,
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
                      initialValue: widget.product,
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
                      initialValue: widget.quantity,
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
                      initialValue: widget.bom,
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
                      initialValue: widget.date,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15.w),
                      ),
                    ),
                    SizedBox(
                      height: 90.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          style: TextButton.styleFrom(
                            padding:
                            EdgeInsets.symmetric(vertical: 30.h, horizontal: 45.w),
                            // Add padding
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(10.0), // Circular border
                            ),
                            backgroundColor: showProducts ? const Color(0xff8c7bc9) : Colors.grey,
                            foregroundColor: Colors.white,
                            shadowColor: Colors.grey.withOpacity(0.5),
                            // Shadow color
                            // Shadow offset
                            elevation: 2.0,
                            // Button elevation for shadow
                          ),
                          onPressed: () {
                            setState(() {
                              showProducts = true;
                            });
                          },
                          child: const Text('Composants'),
                        ),
                        SizedBox(width: 20.w),
                        ElevatedButton(
                          style: TextButton.styleFrom(
                            padding:
                            EdgeInsets.symmetric(vertical: 30.h, horizontal: 45.w),
                            // Add padding
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(10.0), // Circular border
                            ),
                            backgroundColor: showProducts ? Colors.grey : const Color(0xff8c7bc9) ,
                            foregroundColor: Colors.white,
                            shadowColor: Colors.grey.withOpacity(0.5),
                            // Shadow color
                            // Shadow offset
                            elevation: 2.0,
                            // Button elevation for shadow
                          ),
                          onPressed: () {
                            setState(() {
                              showProducts = false;
                            });
                          },
                          child: const Text('Ordres de travail'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              showProducts ? components() : workorder(),

              /*Column(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 65.w),
                    child: Text(
                      'Ordres de travail',
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
                      future: fetchWorkOrders(),
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
                                  return buildListItemWO(record);
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
              ),*/
            ],
          ),
        ));
  }
}
