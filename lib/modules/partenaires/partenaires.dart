import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/components/appBar.dart';
import 'package:mobile_app/components/navbar.dart';
import 'package:mobile_app/modules/facturation/components/AddFact.dart';
import 'package:mobile_app/modules/partenaires/AddPartner.dart';
import 'package:mobile_app/modules/partenaires/list_item.dart';
import 'package:mobile_app/modules/partenaires/client_model.dart';
import 'package:mobile_app/modules/partenaires/detailsClient.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import '../../pages/login_page.dart';

class Partenaires extends StatefulWidget {
  const Partenaires({super.key});

  @override
  State<Partenaires> createState() => _PartenairesState();
}

class _PartenairesState extends State<Partenaires> {
  Future<dynamic> fetchFact() async {

    return odooClient.callKw({
      'model': 'res.partner',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [],
        'fields': [
          'id',
          'name',
          'phone',
          'email',
          'city',
          'street',
          'state_id',
          'country_id',
          'vat',
          'website',
          'zip',
          'image_128',
        ],
      },
    });
  }

  Widget buildListItem(Map<String, dynamic> record) {


    return ListItem(
      displayName: record['name'].toString(),
      city: record['city'].toString(),
      country: record['country_id']is String ? record['country_id'][1].toString() : '',
      email: record['email'].toString(),
      imageUrl: 'https://upload.wikimedia.org/wikipedia/pt/thumb/0/02/Satoru_Gojo.png/180px-Satoru_Gojo.png',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddPartner()));
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
                'Partenaires',
                style: TextStyle(fontSize: 55.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 1900.h,
                child: FutureBuilder(
                    future: fetchFact(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              final record = snapshot.data[index] as Map<String, dynamic>;
                              ClientModel client = ClientModel(
                                  nomClient: '',
                                  rue: '',
                                  ville: '',
                                  etat: '',
                                  codePostal: '',
                                  pays: '',
                                  nTVA: '',
                                  tel: '',
                                  email: '',
                                  siteWeb: '',
                                  imageUrl: '');

                              return GestureDetector(
                                  onTap: () {
                                    client = ClientModel(
                                      nomClient: record['name'] is String ? record['name'] : '',
                                      rue: record['street']is String ? record['street'] : '',
                                      ville: record['city']is String ? record['city'] : '',
                                      etat: record['state_id']is String ? record['state_id'][1] : '',
                                      codePostal: record['zip']is String ? record['zip'] : '',
                                      pays: record['country_id']is String ? record['country_id'][1] : '',
                                      nTVA: record['vat']is String ? record['vat'] : '',
                                      tel: record['phone']is String ? record['phone'] : '',
                                      email: record['email']is String ? record['email'] : '',
                                      siteWeb: record['website']is String ? record['website'] : '',
                                      imageUrl: 'https://upload.wikimedia.org/wikipedia/pt/thumb/0/02/Satoru_Gojo.png/180px-Satoru_Gojo.png',
                                    );
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsClient(
                                                  client: client,
                                                )));
                                  },
                                  child: buildListItem(record));
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
