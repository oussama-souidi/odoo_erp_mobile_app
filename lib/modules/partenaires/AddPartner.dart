import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import '../../../pages/login_page.dart';

class AddPartner extends StatefulWidget {
  AddPartner({super.key});

  @override
  State<AddPartner> createState() => _AddPartnerState();
}

class _AddPartnerState extends State<AddPartner> {
  final nomClient = TextEditingController();
  final rue = TextEditingController();
  final ville = TextEditingController();
  final etat = TextEditingController();
  final codePostal = TextEditingController();
  final pays = TextEditingController();
  final nTVA = TextEditingController();
  final tel = TextEditingController();
  final email = TextEditingController();
  final siteweb = TextEditingController();


  Future<dynamic> addPartnerRPC() async {
    return odooClient.callKw(
      {
        'model': 'res.partner',
        'method': 'create',
        'args': [
          {
            'name': nomClient.text,
            'phone': tel.text,
            'email': email.text,
            'city': ville.text,
            'street': rue.text,
            'vat': nTVA.text,
            'website': siteweb.text,
            'zip': codePostal.text,
          }
        ],
        'kwargs': {}
      },
    );
  }

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
              'Nouveau partenaire',
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
                          controller: nomClient,
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
                      /*ClipRRect(
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
                      )*/
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
                    controller: rue,
                    style: TextStyle(
                        fontSize: 47.sp,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      hintText: 'rue',
                      hintStyle: TextStyle(
                          fontSize: 44.sp, fontWeight: FontWeight.normal),
                      contentPadding:
                          EdgeInsets.only(left: 15.w, bottom: -40.h),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: ville,
                          style: TextStyle(
                              fontSize: 47.sp,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 15.w, bottom: -40.h),
                            hintText: 'ville',
                            hintStyle: TextStyle(
                                fontSize: 44.sp, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.sp,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: etat,
                          style: TextStyle(
                              fontSize: 47.sp,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            hintText: 'état',
                            hintStyle: TextStyle(
                                fontSize: 44.sp, fontWeight: FontWeight.normal),
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
                          controller: codePostal,
                          style: TextStyle(
                              fontSize: 47.sp,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            hintText: 'code postal',
                            hintStyle: TextStyle(
                                fontSize: 44.sp,
                                fontWeight: FontWeight.normal),
                            contentPadding:
                                EdgeInsets.only(left: 15.w, bottom: -40.h),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: pays,
                    style: TextStyle(
                        fontSize: 47.sp,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      hintText: 'pays',
                      hintStyle: TextStyle(
                          fontSize: 44.sp,
                          fontWeight: FontWeight.normal),
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
                    controller: nTVA,
                    style: TextStyle(
                        fontSize: 47.sp,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      hintText: 'n° TVA',
                      hintStyle: TextStyle(
                          fontSize: 44.sp,
                          fontWeight: FontWeight.normal),
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
                    controller: tel,
                    style: TextStyle(
                        fontSize: 47.sp,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      hintText: 'numéro téléphone',
                      hintStyle: TextStyle(
                          fontSize: 44.sp,
                          fontWeight: FontWeight.normal),
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
                    controller: email,
                    style: TextStyle(
                        fontSize: 47.sp,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      hintText: 'émail',
                      hintStyle: TextStyle(
                          fontSize: 44.sp,
                          fontWeight: FontWeight.normal),
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
                    controller: siteweb,
                    style: TextStyle(
                        fontSize: 47.sp,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      hintText: 'lien du site web',
                      hintStyle: TextStyle(
                          fontSize: 44.sp,
                          fontWeight: FontWeight.normal),
                      contentPadding:
                          EdgeInsets.only(left: 15.w, bottom: -40.h),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.r),
              topRight: Radius.circular(50.r),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
              )
            ]),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () async {

                  try {
                    await addPartnerRPC();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Contact created successfully!"),
                    ));
                    Navigator.pop(context, true);
                  } on SocketException catch (e) {
                    print("Unexpected error: $e");
                    // Handle connection problems
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Connection error"),
                    ));
                  } on OdooException catch (e) {
                    print("Unexpected error: $e");
                    // Handle API errors (likely invalid credentials)
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Failed to create new partner."),

                    ));
                  } catch (e) {
                    // Handle API errors
                    print("Unexpected error: $e");
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please try again later."),
                    ));
                  }


                },
                style: TextButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: 30.h, horizontal: 45.w),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Circular border
                  ),
                  backgroundColor: const Color(0xff8c7bc9),
                  foregroundColor: Colors.white,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  // Shadow color
                  // Shadow offset
                  elevation: 2.0, // Button elevation for shadow
                ),
                child: Text(
                  "Confirmer",
                  style: TextStyle(fontSize: 45.sp),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: 30.h, horizontal: 45.w),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Circular border
                  ),
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  elevation: 2.0, // Button elevation for shadow
                ),
                child: Text("Annuler", style: TextStyle(fontSize: 45.sp)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
