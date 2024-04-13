import 'package:controle_aluguel_mobile/models/usuarios/cliente.dart';
import 'package:controle_aluguel_mobile/services/dialogs.dart';
import 'package:controle_aluguel_mobile/services/users/user_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_masked_formatter/multi_masked_formatter.dart';
import 'package:brasil_fields/brasil_fields.dart';

class EditClientPage extends StatefulWidget {

  final Cliente cliente;
  
  const EditClientPage({super.key, required this.cliente});

  @override
  State<EditClientPage> createState() => _EditClientPageState();
}

class _EditClientPageState extends State<EditClientPage> {

  final TextEditingController _email = TextEditingController();
  final TextEditingController _telefone = TextEditingController();
  final TextEditingController _dtnascimento = TextEditingController();
  final TextEditingController _cpf = TextEditingController();
  final TextEditingController _nome = TextEditingController();
  UserServices _userServices = UserServices();
  Dialogs _dialogs = Dialogs();


  late String urlImg;


  @override
  void initState() {
    super.initState();
    carregar(widget.cliente);
  }

  void carregar(Cliente cliente) {
    _email.text = cliente.email!;
    _telefone.text = cliente.telefone!;
    _dtnascimento.text = cliente.dtNascimento!;
    _cpf.text = cliente.cpf!;
    _nome.text = cliente.nome!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Cadastro de Inquilino"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 30, left: 30),
        child: Column(children: [
          SizedBox(height: 30),
          TextFormField(
            controller: _nome,
            decoration: const InputDecoration(
              labelText: "Nome Completo",
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _cpf,
            decoration: const InputDecoration(
              labelText: "CPF",
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              // obrigatório
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter(),
            ],
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _dtnascimento,
            decoration: const InputDecoration(
              labelText: 'Data de nascimento',
              hintText: 'DD/MM/AAAA',
              prefixIcon: Icon(Icons.calendar_today),
            ),
            inputFormatters: [
              MultiMaskedTextInputFormatter(
                masks: ['DD/MM/YYYY'],
                separator: '/',
              ),
            ],
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _email,
            decoration: const InputDecoration(
              labelText: "email",
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _telefone,
            decoration: const InputDecoration(
              labelText: 'Celular',
              hintText: 'xx-xxxxx-xxxx',
            ),
            keyboardType: TextInputType.phone,
            inputFormatters: [
              MultiMaskedTextInputFormatter(
                masks: ['xx-xxxxx-xxxx'],
                separator: '-',
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child:
                    //botao registrar
                    ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: LinearBorder.bottom(),
                  ),

                  onPressed: () async {
                    if (_email.text.isEmpty ||
                        _telefone.text.isEmpty ||
                        _nome.text.isEmpty ||
                        _cpf.text.isEmpty ||
                        _dtnascimento.text.isEmpty) {
                      _dialogs.showErrorDialog(
                          context, 'todos os campos devem ser preenchidos');
                      return;
                    }

                   
                      if (await _userServices.cadastrarCliente(
                        _nome.text,
                        _cpf.text,
                        _dtnascimento.text,
                        _telefone.text,
                        _email.text,
                      )) {
                        Navigator.pop(context);
                      } else {
                        debugPrint("erro, favor repetir");
                      }
                    
                  }, //chamada do signup do user_services (controller)
                  child: const Text(
                    "Salvar",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
        ]),
      ),
    );
  }
}