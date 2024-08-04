import 'package:controle_aluguel_mobile/models/usuarios/cliente.dart';
import 'package:controle_aluguel_mobile/services/cobranca/cobranca_services.dart';
import 'package:controle_aluguel_mobile/services/dialogs.dart';
import 'package:controle_aluguel_mobile/services/users/user_services.dart';
import 'package:flutter/material.dart';

class CobrancaEmailPage extends StatefulWidget {
  const CobrancaEmailPage({super.key});

  @override
  State<CobrancaEmailPage> createState() => _CobrancaEmailPageState();
}

class _CobrancaEmailPageState extends State<CobrancaEmailPage> {
  final TextEditingController _assunto =
      TextEditingController(text: 'Cobrança de Aluguel');
  final TextEditingController _mensagem =
      TextEditingController(text: mensagemCobranca());
  final CobrancaEmailServices _cobrancaServices = CobrancaEmailServices();
  final UserServices _userServices = UserServices();
  late String email = '';
  String _text = '';
  final Dialogs _dialog = Dialogs();
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cobrança por E-mail"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 30, left: 30),
        child: Column(children: [
          //--------------------------------------------------------------------

          FutureBuilder<List<String>>(
            future:
                _userServices.loadNamesFromFirebase() as Future<List<String>>?,
            builder:
                (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              if (snapshot.hasError) {
                return const Text('Erro ao carregar os nomes');
              }

              if (snapshot.connectionState == ConnectionState.done) {
                return DropdownButton<String>(
                  alignment: Alignment.bottomCenter,
                  borderRadius: BorderRadius.circular(10),
                  value: _userServices.selectedCliente,
                  onChanged: (String? newValue) async {
                    setState(() {
                      _userServices.selectedCliente = newValue!;
                    });
                    //final nome = _userServices.selectedCliente;
                    // Map<String, dynamic> data = _userServices
                    //     .buscarClientePorNome(nome) as Map<String, dynamic>;
                    // print(data);

                    email = await _userServices.buscarClientePorNome(newValue!);
                    print(email);

                    //email = data['email'].toString();
                    //_userServices.buscarClientePorNome(nome);
                  },
                  items: snapshot.data!.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                );
              }

              return const CircularProgressIndicator();
            },
          ),
          //------------------------------------------------------------------

          //Map<String, dynamic> data = _userServices.buscarClientePorNome(_userServices.selectedCliente);

          SizedBox(height: 10),
          TextFormField(
            controller: _assunto,
            decoration: const InputDecoration(
              labelText: "Assunto",
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _mensagem,
            minLines: 10,
            maxLines: null,
            decoration: const InputDecoration(
              labelText: "Mensagem",
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              // _cobrancaServices.sendMessage(
              //     _mensagem.text, email, _assunto.text);
              if (await _cobrancaServices.sendMessage(
                      _mensagem.text, email, _assunto.text) ==
                  true) {
                _dialog.showSuccessDialog(
                    context, 'E-mail enviado com sucesso.');
                _text = 'E-mail enviado com sucesso.';
              } else {
                _dialog.showErrorDialog(context, 'Erro ao enviar o e-mail.');
                _text = 'Erro ao enviar o e-mail.';
              }
            },
            child: const Text("Enviar"),
          ),
        ]),
      ),
    );
  }
}

mensagemCobranca() {
  return 'Prezado(a), \n\n'
      'Estamos enviando este e-mail para lembrá-lo(a) de que o aluguel do imóvel está atrasado. \n\n'
      'O valor devido é de R\$ xxxxx e a data de vencimento foi xxxx. \n\n'
      'Por favor, regularize o pagamento o mais rápido possível. \n\n'
      'Dados de pagamento, \n\n'
      'Banco: 341 - Itaú \n'
      'Agência: 1111 \n'
      'Conta: 1111-6 \n';
}
