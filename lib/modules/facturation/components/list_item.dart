import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/modules/achats/components/detailsPage.dart';

class ListItem extends StatelessWidget {
  final String client;
  final String montant;
  final String refFac;
  final String dateFac;
  final String dateEch;
  final String dateLiv;
  final String etat;

  const ListItem(
      {super.key,
      required this.client,
      required this.montant,
      required this.refFac,
      required this.dateFac,
      required this.dateEch,
      required this.dateLiv,
      required this.etat});

  @override
  Widget build(BuildContext context) {
    Color boxColor;
    String text = etat;
    Color borderColor;
    TextStyle textStyle;

    switch (text) {
      case "Comptabilisé":
        boxColor = const Color(0xff4CAF50); // Light purple
        borderColor = Colors.transparent;
        textStyle = TextStyle(color: Colors.white, fontSize: 33.sp);
        break;
      case "Brouillon":
        boxColor = Colors.white;
        borderColor = const Color(0xffbda7d1);
        textStyle = TextStyle(color: Colors.black, fontSize: 33.sp);
        break;
      default:
        // Handle unexpected text by setting default styles (optional)
        boxColor = Colors.grey.shade200;
        borderColor = Colors.transparent;
        textStyle = TextStyle(color: Colors.black, fontSize: 33.sp);
    }

    return GestureDetector(
      onTap: () {
        /*Navigator.push(context, MaterialPageRoute(builder: (context) => detailsPage(
                    fournisseur: fournisseur,
                    montant: montant,
                    id: id,
                    date: date,
                    etat: etat)));*/
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
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
            height: 200.h,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 40.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        client,
                        style: TextStyle(
                            fontSize: 45.sp, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        dateFac,
                        style: TextStyle(
                            fontSize: 45.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$ $montant",
                        style: TextStyle(
                            fontSize: 44.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[700]),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: boxColor,
                            border: Border.all(color: borderColor),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 3.h),
                          child: FittedBox(
                            child: Text(text, style: textStyle),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
