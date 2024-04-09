import 'data_model.dart';

class FakeRepo {
  static List<DataModel> data = [
    DataModel(
      client: "Client 1",
      montant: "48 000",
      refFac: "FAC/2024/00001",
      dateFac: "03/03/2024",
      dateEch: "05/03/2024",
      dateLiv: "03/03/2024",
      etat: "Comptabilisé",
    ),
    DataModel(
        client: "Client 2",
        montant: "5 400",
        refFac: "FAC/2024/00002",
        dateFac: "04/03/2024",
        dateEch: "06/03/2024",
        dateLiv: "04/03/2024",
        etat: "Comptabilisé"),
    DataModel(
        client: "Client 3",
        montant: "7 600",
        refFac: "FAC/2024/00003",
        dateFac: "02/03/2024",
        dateEch: "04/03/2024",
        dateLiv: "02/03/2024",
        etat: "Brouillon"),
  ];
}
