import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_aluguel_mobile/models/contrato/contrato.dart';

Contrato contratoModel = Contrato();
final CollectionReference contratoCollection =
    FirebaseFirestore.instance.collection('contrato');
final CollectionReference casaCollection =
    FirebaseFirestore.instance.collection('casa');
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
CollectionReference get _collectionCliente => _firestore.collection('cliente');

class ContratoServices {
  Future<List<Contrato>> allContratos() async {
    QuerySnapshot querySnapshot = await contratoCollection.get();
    return querySnapshot.docs.map((doc) {
      return Contrato(
        id: doc.id,
        cpfCliente: doc['cpfCliente'],
        idCasa: doc['idCasa'],
        valorMensal: doc['valorMensal'],
        dtInicioContrato: doc['dtInicioContrato'],
        dtFinalContrato: doc['dtFinalContrato'],
        tempoContrato: doc['tempoContrato'],
        dtVencimento: doc['dtVencimento'],
      );
    }).toList();
  }

  Future<bool> cadastrarContrato(cliente, casa, dtInicioContrato,
      dtFinalContrato, tempoContrato, valorMensal, dtVencimento) async {
    contratoModel.cpfCliente = await getCpfCliente(cliente);
    contratoModel.idCasa = await getCasaId(casa);
    contratoModel.dtInicioContrato = dtInicioContrato;
    contratoModel.dtFinalContrato = dtFinalContrato;
    contratoModel.tempoContrato = tempoContrato;
    contratoModel.valorMensal = valorMensal;
    contratoModel.dtVencimento = dtVencimento;
    contratoModel.toJson();

    try {
      final userDocRef = _firestore.collection('contrato').doc();
      final atualizaStatus = _firestore.collection('casa');

      if (!(await userDocRef.get()).exists) {
        // A coleção não existe, crie-a e insira os dados
        await userDocRef.set(contratoModel.toJson());
      } else {
        // A coleção já existe, atualize os dados conforme necessário
        await userDocRef.update(contratoModel.toJson());
      }

      contratoModel.id = userDocRef.id;

      await userDocRef.update(contratoModel.toJsonid());

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('casa')
          .where('nome', isEqualTo: casa)
          .get();

      querySnapshot.docs.forEach((doc) {
        atualizaStatus.doc(doc.id).update({'alugada': 'true'});
      });

      print('Dados salvos com sucesso.');
    } catch (e) {
      print('Erro ao salvar os dados: $e');
    }
    return Future.value(true);
  }

  //retorna o id da casa, usado no cadastro do contrato
  Future<String> getCasaId(String casa) async {
    final query = await casaCollection.where('nome', isEqualTo: casa).get();
    final querySnapshot = query.docs;

    if (querySnapshot.isNotEmpty) {
      return querySnapshot[0].id;
    } else {
      return '';
    }
  }

  //retorna o nome da casa a partir do id, usado na listagem de contratos
  Future<String> getCasaNome(String id) async {
    final query = await casaCollection.doc(id).get();
    String casa = query['nome'].toString();
    return Future.value(casa);
  }

  //retorna o nome do cliente a partir do cpf, usado na listagem de contratos
  getClienteNome(String cpf) async {
    final query = await _collectionCliente.doc(cpf).get();
    String cliente = query['nome'].toString();
    return Future.value(cliente);
  }

  //retorna o cpf do cliente, usado no cadastro do contrato
  Future<String> getCpfCliente(String cliente) async {
    final query =
        await _collectionCliente.where('nome', isEqualTo: cliente).get();
    final querySnapshot = query.docs;

    if (querySnapshot.isNotEmpty) {
      return querySnapshot[0].id;
    } else {
      return '';
    }
  }

  Future<bool> atualizarContrato(id, cpfCliente, idCasa, dtInicioContrato,
      dtFinalContrato, tempoContrato, valorMensal, dtVencimento) async {
    contratoModel.cpfCliente = cpfCliente;
    contratoModel.idCasa = idCasa;
    contratoModel.dtInicioContrato = dtInicioContrato;
    contratoModel.dtFinalContrato = dtFinalContrato;
    contratoModel.tempoContrato = tempoContrato;
    contratoModel.valorMensal = valorMensal;
    contratoModel.dtVencimento = dtVencimento;
    contratoModel.toJson();

    try {
      final userDocRef = _firestore.collection('contrato').doc(id);

      await userDocRef.update(contratoModel.toJson());

      print('Dados salvos com sucesso.');
    } catch (e) {
      print('Erro ao salvar os dados: $e');
    }
    return Future.value(true);
  }

  Future<void> deleteContrato(String id, casa) async {
    final query = await casaCollection.doc(casa);
    final querySnapshot = await query.get();

    if (querySnapshot.exists) {
      query.update({'alugada': 'false'});
    }

    await contratoCollection.doc(id).delete();
  }

  Future<void> loadDataFromFirebase(String id) async {
    try {
      final documentSnapshot =
          await FirebaseFirestore.instance.collection('contrato').doc(id).get();
      contratoModel.id = id;
      contratoModel.cpfCliente = documentSnapshot['cpfCliente'];
      contratoModel.idCasa = documentSnapshot['idCasa'];
      contratoModel.dtInicioContrato = documentSnapshot['dtInicioContrato'];
      contratoModel.dtFinalContrato = documentSnapshot['dtFinalContrato'];
      contratoModel.tempoContrato = documentSnapshot['tempoContrato'];
      contratoModel.valorMensal = documentSnapshot['valorMensal'];
      contratoModel.dtVencimento = documentSnapshot['dtVencimento'];
    } catch (e) {
      print(e);
      throw e;
    }
  }

  late String selectedContrato = '';

  Future<List<String>> loadNamesFromFirebase() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('contrato').get();
    final List<String> names = querySnapshot.docs
        .map((QueryDocumentSnapshot documentSnapshot) =>
            documentSnapshot['idCasa'] as String)
        .toList();

    if (!names.isEmpty && selectedContrato.isEmpty) {
      selectedContrato = names[0];
    }
    return names;
  }
}
