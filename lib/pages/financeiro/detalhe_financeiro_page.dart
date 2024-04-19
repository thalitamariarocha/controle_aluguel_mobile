import 'package:controle_aluguel_mobile/models/contrato/contrato.dart';
import 'package:controle_aluguel_mobile/models/financeiro/financeiro.dart';
import 'package:controle_aluguel_mobile/pages/financeiro/cad_financeiro_page.dart';
import 'package:controle_aluguel_mobile/services/dialogs.dart';
import 'package:controle_aluguel_mobile/services/financeiro/financeiro_services.dart';
import 'package:flutter/material.dart';

class DetalheFinanceiroPage extends StatefulWidget {
  final Contrato contratoModel;
  final String nomeCasa;
  final String nomeCliente;
  const DetalheFinanceiroPage(
      {Key? key,
      required this.contratoModel,
      required this.nomeCasa,
      required this.nomeCliente});

  @override
  State<DetalheFinanceiroPage> createState() => _DetalheFinanceiroPageState();
}

class _DetalheFinanceiroPageState extends State<DetalheFinanceiroPage> {
  FinanceiroServices _financeiroServices = FinanceiroServices();
  Financeiro financeiro = Financeiro();
  Dialogs _dialogsService = Dialogs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Financeiro'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            const Center(
              child: Text(
                "Detalhes do contrato",
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('Nome do Cliente: ${widget.nomeCliente}'),
                    // Text(widget.nomeCliente),
                  ],
                ),
                Column(
                  children: [
                    Text('Nome da Casa: ${widget.nomeCasa}'),
                    //Text(widget.nomeCasa),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                        'Data de Início: ${widget.contratoModel.dtInicioContrato!}'),
                    //Text(widget.contratoModel.dtInicioContrato!),
                  ],
                ),
                Column(
                  children: [
                    Text(
                        'Data Final: ${widget.contratoModel.dtFinalContrato!}'),
                    //Text(widget.contratoModel.dtFinalContrato!),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                        'Valor do Aluguel: ${widget.contratoModel.valorMensal}'),
                    //Text(widget.contratoModel.valorMensal.toString()),
                  ],
                ),
                Column(
                  children: [
                    Text(
                        'Dia de Vencimento: ${widget.contratoModel.dtVencimento}'),
                    //Text(widget.contratoModel.dtVencimento.toString()),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 10,
              width: double.infinity,
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.0, color: Colors.grey),
                  ),
                ),
              ),
            ),
            FutureBuilder<List<Financeiro>>(
              future:
                  _financeiroServices.allPagamentos(widget.contratoModel.id!),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Text('Sem dados cadastrados');
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Data de Pagamento: ${snapshot.data![index].dtPagamento}'),
                                  Text(
                                      'Valor do Pagamento: ${snapshot.data![index].vlrPagamento}'),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => CadFinanceiroPage(
                                      //       financeiroModel: snapshot.data![index],
                                      //     ),
                                      //   ),
                                      // );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                const Text('Deletar Contrato'),
                                            content: const Text(
                                                'Deseja realmente Deletar o contrato?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Cancelar'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  await _financeiroServices
                                                      .deleteCadastro(snapshot
                                                          .data![index].id);
                                                  Navigator.of(context).pop();

                                                  _dialogsService
                                                      .showSuccessDialog(
                                                    context,
                                                    'item apagado com sucesso',
                                                  );
                                                  setState(() {});
                                                },
                                                child: const Text('Excluir'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CadFinanceiroPage(
                            contratoModel: widget.contratoModel,
                            ),
                      ),
                    );
                  },
                  child: const Text('Cadastrar nova entrada'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
