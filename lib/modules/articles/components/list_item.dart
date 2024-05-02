import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/articles/components/detailsPage.dart';

class ListItem extends StatelessWidget {
  final String nomProduit;
  final String refProduit;
  final String prixVente;
  final String cout;
  final String quantite;

  const ListItem(
      {super.key,
      required this.nomProduit,
      required this.refProduit,
      required this.prixVente,
      required this.cout,
      required this.quantite});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => detailsPage(
                    nomProduit: nomProduit,
                    refProduit: refProduit,
                    prixVente: prixVente,
                    cout: cout,
                    quantite: quantite)));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1),
              borderRadius: BorderRadius.circular(40.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    offset: const Offset(0, 3))
              ]),
          child: SizedBox(
            height: 350.h,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        nomProduit,
                        style:
                            TextStyle(fontSize: 45.sp, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        refProduit != '' ? '[$refProduit]' : '',
                        style: TextStyle(
                            fontSize: 45.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700]),
                      ),
                      SizedBox(height: 20.h,),
                      Text(
                        'Prix : \$ $prixVente',
                        style: TextStyle(
                            fontSize: 44.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700]),
                      ),
                      Text(
                        quantite != '' ? 'En stock : $quantite Unité(s)' : '',
                        style: TextStyle(
                            fontSize: 45.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700]),
                      ),
                    ],
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
                          height: 300.h,
                          width: 170.w,
                          image:  const NetworkImage('https://upload.wikimedia.org/wikipedia/pt/thumb/0/02/Satoru_Gojo.png/180px-Satoru_Gojo.png',
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
