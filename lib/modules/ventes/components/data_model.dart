import 'package:mobile_app/modules/facturation/clients/client_model.dart';

class DataModel {
  final ClientModel client;
  final String montant;
  final String id;
  final String date;
  final String etat;

  DataModel({required this.client, required this.montant, required this.id, required this.date, required this.etat});
}
