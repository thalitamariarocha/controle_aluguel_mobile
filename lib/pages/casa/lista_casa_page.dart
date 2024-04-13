import 'package:controle_aluguel_mobile/models/casa/casa.dart';
import 'package:controle_aluguel_mobile/models/usuarios/cliente.dart';
import 'package:controle_aluguel_mobile/pages/casa/cad_casa_page.dart';
import 'package:controle_aluguel_mobile/pages/clientes/cad_cliente_page.dart';
import 'package:controle_aluguel_mobile/pages/home.dart';
import 'package:controle_aluguel_mobile/services/casa/casa_services.dart';
import 'package:controle_aluguel_mobile/services/dialogs.dart';
import 'package:controle_aluguel_mobile/services/users/user_services.dart';
import 'package:flutter/material.dart';

CasaServices _casaServices = CasaServices();
Dialogs _dialogsService = Dialogs();

class ListaCasa extends StatefulWidget {
  const ListaCasa({super.key});

  @override
  State<ListaCasa> createState() => _ListaCasaPageState();
}

class _ListaCasaPageState extends State<ListaCasa> {
  @override
  void didUpdateWidget(covariant ListaCasa oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Casas"),
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
              FutureBuilder<List<Casa>>(
                future: _casaServices.allCasas(),
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
                        final imageUrl = snapshot.data![index].image ?? '';
                        final id = snapshot.data![index].id ?? '';
                        final nome = snapshot.data![index].nome ?? '';
                        final endereco = snapshot.data![index].endereco ?? '';

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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //Image.network(imageUrl),
                                Text(nome),
                                Text(endereco),
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           EditContratoPage(
                                    //             idContrato: id,
                                    //           )),
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
                                                await _casaServices
                                                    .deleteCadastro(id);
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
                        builder: (context) => CadCasaPage(),
                      ),
                    );
                  },
                  child: const Text('Nova Casa'),
                ),
              ),
            ],
          ),
        ));
  }
}
