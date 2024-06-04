import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/articles/components/list_item.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import '../../pages/login_page.dart';
import 'components/AddProduct.dart';

class Articles extends StatefulWidget {
  Articles({super.key});

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {


  Future<dynamic> fetchArticles() async {

    return odooClient.callKw({
      'model': 'product.template',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true, 'lang': 'fr_FR'},
        'domain': [],
        'fields': [
          'name',
          'default_code',
          'list_price',
          'standard_price',
          'qty_available'
        ],
      },
    });
  }

  Widget buildListItem(Map<String, dynamic> record) {
    return ListItem(
        nomProduit: record['name'] is String ? record['name'] : '',
        refProduit: record['default_code'] is String ? record['default_code'] : '',
        prixVente: record['list_price'].toString(),
        cout: record['standard_price'].toString(),
        quantite: record['qty_available'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddProduct()));
            if (result){
              setState(() {
              });
            }
            },
          backgroundColor: const Color(0xff8c7bc9),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
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
                  future: fetchArticles(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
