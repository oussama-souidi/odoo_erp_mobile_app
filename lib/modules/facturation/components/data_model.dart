import 'package:mobile_app/modules/facturation/clients/client_model.dart';

class DataModel {
  final ClientModel client;
  final String montant;
  final String refFac;
  final String dateFac;
  final String dateEch;
  final String dateLiv;
  final String etat;

  DataModel(
      {required this.client,
      required this.montant,
      required this.refFac,
      required this.dateFac,
      required this.dateEch,
      required this.dateLiv,
      required this.etat});
}
