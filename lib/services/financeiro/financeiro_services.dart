import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_aluguel_mobile/models/financeiro/financeiro.dart';
import 'package:flutter/material.dart';

class FinanceiroServices {
  final diaHoje = DateTime.now();
  Financeiro financeiro = Financeiro();
  final _collectionRef = FirebaseFirestore.instance.collection('financeiro');

  Future<void> pagar() async {
    await Future.delayed(Duration(seconds: 1));
    print('Pagamento realizado com sucesso!');
  }

  Future<String> totalRecebido(idContrato) async {
    double total = 0.0;
    QuerySnapshot querySnapshot =
        await _collectionRef.where('idContrato', isEqualTo: idContrato).get();
    for (var doc in querySnapshot.docs) {
      print('vlrPagamento: ${doc['vlrPagamento']}');

      double vlrPagamento = double.parse(doc['vlrPagamento'].toString());
      total += vlrPagamento; // Add to total
    }

    return total.toString();
  }

  Future<List<Financeiro>> allPagamentos(idContrato) async {
    // QuerySnapshot querySnapshot =
    //     await _collectionRef.orderBy('dtPagamento').get();
    QuerySnapshot querySnapshot = await _collectionRef
        .where('idContrato', isEqualTo: idContrato)
        // .orderBy('dtPagamento')
        .get();
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

  Future<bool> save(Financeiro financeiro) async {
    try {
      await _collectionRef.add(financeiro.toJson());
      print('Pagamento salvo com sucesso.');

      _collectionRef
          .where('idContrato', isEqualTo: financeiro.idContrato)
          .get()
          .then((value) {
        final id = value.docs[0].id;

        _collectionRef.doc(id).update({
          'id': id,
        });
      });

      return true;
    } catch (e) {
      print('Erro ao salvar o pagamento: $e');

      return false;
    }
  }

  Future<bool> updateCadastro(Financeiro financeiro) async {
    try {
      await _collectionRef.doc(financeiro.id).update(financeiro.toJson());
      print('Dados atualizados com sucesso.');
      return true;
    } catch (e) {
      print('Erro ao atualizar os dados: $e');
      return false;
    }
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
