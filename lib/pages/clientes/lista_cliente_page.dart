import 'package:controle_aluguel_mobile/models/usuarios/cliente.dart';
import 'package:controle_aluguel_mobile/pages/clientes/cad_cliente_page.dart';
import 'package:controle_aluguel_mobile/pages/clientes/edit_cliente_page.dart';
import 'package:controle_aluguel_mobile/pages/home.dart';
import 'package:controle_aluguel_mobile/services/dialogs.dart';
import 'package:controle_aluguel_mobile/services/users/user_services.dart';
import 'package:flutter/material.dart';

UserServices _userServices = UserServices();
Dialogs _dialogsService = Dialogs();

class ListaCliente extends StatefulWidget {
  const ListaCliente({super.key});

  @override
  State<ListaCliente> createState() => _ListaClientePageState();
}

class _ListaClientePageState extends State<ListaCliente> {
  @override
  void didUpdateWidget(covariant ListaCliente oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
        appBar: AppBar(
          title: const Text("Clientes"),
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
              FutureBuilder<List<Cliente>>(
                future: _userServices.allClientes(),
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
                        final nome = snapshot.data![index].nome ?? '';
                        final cpf = snapshot.data![index].cpf ?? '';
                        final id = snapshot.data![index].id;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(nome),
                            Text(cpf),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditClientPage(
                                            cliente: snapshot.data![index],
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
                                            await _userServices
                                                .deleteCadastro(id);

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
                        builder: (context) => CadastroCliente(),
                      ),
                    );
                  },
                  child: const Text('Novo Cliente'),
                ),
              ),
            ],
          ),
        ));
  }
}
