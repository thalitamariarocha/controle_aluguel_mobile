import 'package:controle_aluguel_mobile/models/contrato/contrato.dart';
import 'package:controle_aluguel_mobile/pages/casa/cad_casa_page.dart';
import 'package:controle_aluguel_mobile/pages/contratos/cad_contrato_page.dart';
import 'package:controle_aluguel_mobile/pages/contratos/edit_contrato_page.dart';
import 'package:controle_aluguel_mobile/pages/home.dart';
import 'package:controle_aluguel_mobile/services/contrato/contrato_services.dart';
import 'package:controle_aluguel_mobile/services/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

ContratoServices _contratoServices = ContratoServices();
Dialogs _dialogsService = Dialogs();

class ListaContrato extends StatefulWidget {
  const ListaContrato({super.key});

  @override
  State<ListaContrato> createState() => _ListaContratoState();
}

class _ListaContratoState extends State<ListaContrato> {
  @override
  void didUpdateWidget(covariant ListaContrato oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              FutureBuilder<List<Contrato>>(
                future: _contratoServices.allContratos(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.data == null) {
                    return const Text('Sem dados cadastrados');
                  }

                  if (snapshot.data != null) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        // Acessa os campos casa e cliente e fornece um valor padrão caso sejam nulos

          
                          final nomeCasa = casaCollection
                              .doc(snapshot.data![index].idCasa)
                              .get()
                              .then((query) => query['nome'].toString());
                        

                        //_contratoServices.getCasaNome(snapshot.data![index].idCasa ?? 'No data');

                        // final cliente = _contratoServices.getClienteNome(
                        //     snapshot.data![index].cpfCliente ?? 'No data');
                        // snapshot.data![index].cliente ?? 'No data';
                        final id = snapshot.data![index].id;
                        final dtInicioContrato =
                            snapshot.data![index].dtInicioContrato;
                        final dtFinalContrato =
                            snapshot.data![index].dtFinalContrato;

                        return Row (
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(nomeCasa as String),
                                // Text(cliente.toString()),
                              ],
                            ),
                            Column(
                              children: [
                                Text(dtInicioContrato!),
                                Text(dtFinalContrato!),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditContratoPage(
                                            contratoModel:
                                                snapshot.data![index],
                                          )),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Deletar Contrato'),
                                      content: const Text(
                                          'Deseja realmente Deletar o contrato?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            // Fechar o diálogo quando o botão "Cancelar" for pressionado
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            //Navigator.of(context).pop();
                                            await _contratoServices
                                                .deleteContrato(
                                                    snapshot.data![index].id ??
                                                        '',
                                                    snapshot.data![index]
                                                            .idCasa ??
                                                        '');

                                            Navigator.of(context).pop();

                                            _dialogsService.showSuccessDialog(
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
                        );
                      },
                    );
                  } else {
                    // Se snapshot.data for nulo, exibe uma mensagem de erro ou um indicador de carregamento
                    return Text('No data available');
                  }
                },
              ),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(300, 50)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CadContratoPage(),
                      ),
                    );
                  },
                  child: const Text('Novo Contrato'),
                ),
              ),
            ],
          ),
        ));
  }
}
