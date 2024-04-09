import 'package:mobile_app/modules/facturation/clients/client_model.dart';

class FakeRepo {
  static List<ClientModel> data = [
    ClientModel(
        nomClient: 'Deco Addict',
        rue: '77 Santa Barbara Rd',
        ville: 'Pleasant Hill',
        etat: 'CA',
        codePostal: '94523',
        pays: 'Etats-Unis',
        nTVA: 'US12345673',
        tel: '(603)-996-3829',
        email: 'deco_addict@yourcompany.example.com',
        siteWeb: 'http://www.deco-addict.com'),
    ClientModel(
        nomClient: 'Azure Interior',
        rue: '4557 De Silva St',
        ville: 'Fremont',
        etat: 'California (US)',
        codePostal: '94538',
        pays: 'Etats-Unis',
        nTVA: 'US12345677',
        tel: '(870)-931-3853',
        email: 'azure.Interior24@example.com',
        siteWeb: 'http://www.azure-interior.com'),
  ];
}
