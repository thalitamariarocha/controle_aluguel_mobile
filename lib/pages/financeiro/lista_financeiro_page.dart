import 'package:controle_aluguel_mobile/models/contrato/contrato.dart';
import 'package:controle_aluguel_mobile/pages/casa/cad_casa_page.dart';
import 'package:controle_aluguel_mobile/pages/contratos/cad_contrato_page.dart';
import 'package:controle_aluguel_mobile/pages/contratos/edit_contrato_page.dart';
import 'package:controle_aluguel_mobile/pages/financeiro/detalhe_financeiro_page.dart';
import 'package:controle_aluguel_mobile/pages/home.dart';
import 'package:controle_aluguel_mobile/services/contrato/contrato_services.dart';
import 'package:controle_aluguel_mobile/services/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

ContratoServices _contratoServices = ContratoServices();
Dialogs _dialogsService = Dialogs();

class ListaFinanceiro extends StatefulWidget {
  ListaFinanceiro({super.key});

  @override
  State<ListaFinanceiro> createState() => _ListaFinanceiroState();
}

class _ListaFinanceiroState extends State<ListaFinanceiro> {
  DateTime hoje = DateTime.now();
  List<Contrato> contratos = [];
  List<Map<String, dynamic>> listagemContrato = [];
  // @override
  // void didUpdateWidget(covariant ListaFinanceiro oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  // }

  Future<String> getCasaNome(String idCasa) async {
    String nomeCasa = await _contratoServices.getCasaNome(idCasa);
    return nomeCasa;
  }

  Future<String> getClienteNome(String cpfCliente) async {
    String nomeCliente = await _contratoServices.getClienteNome(cpfCliente);
    return nomeCliente;
  }

  Future<List<Map<String, dynamic>>> getAllContratos() async {
    contratos = await _contratoServices.allContratos();
    for (final contrato in contratos) {
      String nomeCasa = await getCasaNome(contrato.idCasa!);
      String nomeCliente = await getClienteNome(contrato.cpfCliente!);
      listagemContrato.add({
        'id': contrato.id,
        'cpfCliente': contrato.cpfCliente,
        'idCasa': contrato.idCasa,
        'nomeCasa': nomeCasa,
        'nomeCliente': nomeCliente,
        'valorMensal': contrato.valorMensal,
        'dtInicioContrato': contrato.dtInicioContrato,
        'dtFinalContrato': contrato.dtFinalContrato,
        'tempoContrato': contrato.tempoContrato,
        'dtVencimento': contrato.dtVencimento,
      });
    }
    return listagemContrato;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //setState(() {});
    return Scaffold(
        appBar: AppBar(
          title: const Text("Contratos"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              const Text("selecione o contrato:"),
              const SizedBox(
                height: 5,
              ),
              FutureBuilder(
                future: getAllContratos(), // _contratoServices.allContratos(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (!snapshot.hasData) {
                    return const Text('Sem dados cadastrados');
                  }
                  if (snapshot.hasData) {
                    List<Map<String, dynamic>> contratoMap = snapshot.data!;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: contratoMap.length,
                        itemBuilder: (context, index) {
                          var keysList = contratoMap[index].keys.toList();

                          // Acessa os campos casa e cliente e fornece um valor padrão caso sejam nulos
                          debugPrint(
                              'Future Builder -> casa ${contratoMap[index]['cpfCliente']}');

                          final dtInicioContrato =
                              contratoMap[index]['dtInicioContrato'];
                          final dtFinalContrato =
                              contratoMap[index]['dtFinalContrato'];

                          return Column(
                            children: [
                              SizedBox(
                                height: 10,
                                width: double.infinity,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          width: 1.0, color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(contratoMap[index]['nomeCliente']),
                                      Text(contratoMap[index]['nomeCasa']),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Inicio - ' + dtInicioContrato),
                                      Text('Final - ' + dtFinalContrato),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetalheFinanceiroPage(
                                                  contratoModel: Contrato(
                                                    cpfCliente:
                                                        contratoMap[index]
                                                            ['cpfCliente'],
                                                    dtFinalContrato:
                                                        contratoMap[index]
                                                            ['dtFinalContrato'],
                                                    dtInicioContrato:
                                                        contratoMap[index][
                                                            'dtInicioContrato'],
                                                    id: contratoMap[index]
                                                        ['id'],
                                                    idCasa: contratoMap[index]
                                                        ['idCasa'],
                                                    tempoContrato:
                                                        contratoMap[index]
                                                            ['tempoContrato'],
                                                    valorMensal:
                                                        contratoMap[index]
                                                            ['valorMensal'],
                                                    dtVencimento:
                                                        contratoMap[index]
                                                            ['dtVencimento'],
                                                  ),
                                                  nomeCasa: contratoMap[index]
                                                      ['nomeCasa'],
                                                  nomeCliente:
                                                      contratoMap[index]
                                                          ['nomeCliente'],
                                                ),
                                              ),
                                            );
                                            setState(() {});
                                          },
                                          icon: Icon(Icons.settings)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                        });
                  } else {
                    // Se snapshot.data for nulo, exibe uma mensagem de erro ou um indicador de carregamento
                    return Text('No data available');
                  }
                },
              ),
            ],
          ),
        ));
  }
}
