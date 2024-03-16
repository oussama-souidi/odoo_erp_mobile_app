import 'package:flutter/material.dart';
import 'package:mobile_app/modules/achats/components/details_page.dart';

class Achats extends StatelessWidget {
  const Achats({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => details_page()));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Azure Interior",
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$2222222',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "\#P00010",
                      style:
                          TextStyle(fontSize: 16.0, fontWeight: FontWeight.w100, color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '19/02/2024',
                      style:
                          TextStyle(fontSize: 16.0, fontWeight: FontWeight.w100, color: Colors.grey[700]),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffbda7d1),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                    child: Text("Bon de commande founisseur",
                        style: TextStyle(color: Colors.white, fontSize: 12.0)),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
    ;
  }
}
