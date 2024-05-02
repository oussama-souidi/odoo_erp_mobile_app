import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/partenaires/client_model.dart';

class DetailsClient extends StatelessWidget {
  final ClientModel client;

  const DetailsClient({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(145.h),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: Colors.black87,
            ),
            title: Text(
              client.nomClient,
              style: TextStyle(color: Colors.black87, fontSize: 55.sp),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 70.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Client',
                    style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          initialValue: client.nomClient,
                          style: TextStyle(
                              fontSize: 60.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                          decoration: InputDecoration(

                            contentPadding:
                                EdgeInsets.only(left: 15.w, bottom: -40.h),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.sp,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        // Adjust corner radius
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade500,
                              width: 1,
                            ),
                          ),
                          child: Image(
                              fit: BoxFit.cover,
                              height: 150.h,
                              width: 300.w,
                              image: NetworkImage(client.imageUrl)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  Text(
                    'Adresse',
                    style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  TextFormField(
                    readOnly: true,
                    initialValue: client.rue,
                    style: TextStyle(
                        fontSize: 47.sp,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 15.w, bottom: -40.h),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          initialValue: client.ville,
                          style: TextStyle(
                              fontSize: 47.sp,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 15.w, bottom: -40.h),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.sp,
                      ),
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          initialValue: client.etat,
                          style: TextStyle(
                              fontSize: 47.sp,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 15.w, bottom: -40.h),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.sp,
                      ),
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          initialValue: client.codePostal,
                          style: TextStyle(
                              fontSize: 47.sp,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 15.w, bottom: -40.h),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    readOnly: true,
                    initialValue: client.pays,
                    style: TextStyle(
                        fontSize: 47.sp,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 15.w, bottom: -40.h),
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  Text(
                    'N° TVA',
                    style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  TextFormField(
                    readOnly: true,
                    initialValue: client.nTVA,
                    style: TextStyle(
                        fontSize: 47.sp,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 15.w, bottom: -40.h),
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  Text(
                    'Téléphone',
                    style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  TextFormField(
                    readOnly: true,
                    initialValue: client.tel,
                    style: TextStyle(
                        fontSize: 47.sp,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 15.w, bottom: -40.h),
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  Text(
                    'Email',
                    style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  TextFormField(
                    readOnly: true,
                    initialValue: client.email,
                    style: TextStyle(
                        fontSize: 47.sp,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 15.w, bottom: -40.h),
                    ),
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  Text(
                    'Site Web',
                    style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  TextFormField(
                    readOnly: true,
                    initialValue: client.siteWeb,
                    style: TextStyle(
                        fontSize: 47.sp,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 15.w, bottom: -40.h),
                    ),
                  ),
                ],
              ),
            ),
            /*Padding(
              padding: EdgeInsets.only(bottom: 50.h, top: 50.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 65.w, bottom: 20.h),
                    child: Text(
                      'Lignes de facture',
                      style: TextStyle(
                          fontSize: 55.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: 50.h,
                  ),
                  for (var data in produits)
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 30.w),
                      child: ProductItem(
                          produit: data.produit,
                          quantite: data.quantite,
                          prixUnitaire: data.prixUnitaire,
                          prixHorsTax: data.prix_horsTax,
                          prixAvecTax: data.prix_avecTax),
                    )
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
