import 'package:mobile_app/modules/achats/produits/data_model.dart';

class FakeRepo {
  static List<DataModel> data = [
    DataModel(
        produit: 'Table',
        quantite: '2.00',
        prixUnitaire: '60.00',
        prix_horsTax: '120.00',
        prix_avecTax: '140.00'),
    DataModel(
        produit: 'Laptop',
        quantite: '1.00',
        prixUnitaire: '2600.00',
        prix_horsTax: '2600.00',
        prix_avecTax: '2750.00'),

  ];
}
