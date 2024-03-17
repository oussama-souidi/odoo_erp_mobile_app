import 'package:flutter/material.dart';

class details_page extends StatefulWidget {
  const details_page({super.key});

  @override
  State<details_page> createState() => _details_pageState();
}

class _details_pageState extends State<details_page> {
  DateTime? selectedDate;
  bool isChecked = false;

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: const Color(0xff8c7bc9),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text(
                'Demande de prix',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Fournisseur',
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w100,
                    color: Colors.grey[700]),
              ),
              TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 5),
                  hintText: 'Nom, numéro de TVA, email ou référence',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Référence fournisseur',
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w100,
                    color: Colors.grey[700]),
              ),
              TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 5)
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Échéance de commande',
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w100,
                    color: Colors.grey[700]),
              ),
              TextField(
                readOnly: true, // Disable text editing
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  hintText: selectedDate?.toString().substring(0, 10) ?? 'Select Date',
                  contentPadding: EdgeInsets.only(left: 5)
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Arrivée prévue',
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w100,
                    color: Colors.grey[700]),
              ),
              TextField(
                readOnly: true, // Disable text editing
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  hintText: selectedDate?.toString().substring(0, 10) ?? 'Select Date',
                  contentPadding: EdgeInsets.only(left: 5)
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isChecked = newValue!;
                      });
                    },
                  ),
                  Text('Demande de confirmation',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w100,
                        color: Colors.grey[700])
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
