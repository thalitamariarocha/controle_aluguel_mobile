import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_aluguel_mobile/models/financeiro/financeiro.dart';

class FinanceiroServices {
  final diaHoje = DateTime.now();
  Financeiro financeiro = Financeiro();
  final _collectionRef = FirebaseFirestore.instance.collection('financeiro');

  Future<void> pagar() async {
    await Future.delayed(Duration(seconds: 1));
    print('Pagamento realizado com sucesso!');
  }

  calculoVencimento(dtVencimento) {
    // return DateTime.now().add(Duration(days: 30));
  }

  Future<List<Financeiro>> allPagamentos(idContrato) async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    return querySnapshot.docs.map((doc) {
      return Financeiro(
        id: doc.id,
        dtPagamento: doc['dtPagamento'],
        vlrPagamento: doc['vlrPagamento'],
        formaPagamento: doc['formaPagamento'],
        descricao: doc['descricao'],
        idContrato: doc['idContrato'],
      );
    }).toList();
  }

  Future<void> save(Financeiro financeiro) async {
    try {
      await _collectionRef.add(financeiro.toJson());
      //final userDocRef = _firestore.collection('casa').doc();

      print('Pagamento salvo com sucesso.');
    } catch (e) {
      print('Erro ao salvar o pagamento: $e');
    }
    financeiro.id = _collectionRef.doc().id;
    await _collectionRef.doc(financeiro.id).update({'id': financeiro.id});
  }

  deleteCadastro(id) async {
    try {
      await FirebaseFirestore.instance
          .collection('financeiro')
          .doc(id)
          .delete();
      print('Dados excluídos com sucesso.');
    } catch (e) {
      print('Erro ao excluir os dados: $e');
    }
  }
}
