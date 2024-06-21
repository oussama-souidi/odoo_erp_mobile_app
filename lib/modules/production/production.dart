import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../pages/login_page.dart';
import '../production/components/list_item.dart';

class Production extends StatelessWidget {
  const Production({super.key});

  Future<dynamic> fetchMO() async {
    return odooClient.callKw({
      'model': 'mrp.production',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [["state", "in", ["draft", "confirmed", "progress", "to_close"]]],
        'fields': ['product_id', 'name','product_qty','state','date_start','bom_id'],
      },
    });
  }

  Widget buildListItem(Map<String, dynamic> record) {
    return ListItem(
      name: record['name'].toString(),
      product: record['product_id'][1].toString(),
      quantity: record['product_qty'].toString(),
      date: record['date_start'].toString(),
      etat: record['state'].toString(),
      bom: record['bom_id'][1].toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
                'Ordres de fabrication',
                style: TextStyle(fontSize: 55.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 1900.h,
                child: FutureBuilder(
                    future: fetchMO(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
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
    );
  }
}
