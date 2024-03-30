import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';



class AjouterProduit extends StatefulWidget {
  const AjouterProduit({super.key});

  @override
  State<AjouterProduit> createState() => _details_pageState();
}

class _details_pageState extends State<AjouterProduit> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: const Color(0xff8c7bc9),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Créer Lignes de commande",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
        ),
      ),
    );
  }
}
