import 'package:controle_aluguel_mobile/models/contrato/contrato.dart';
import 'package:controle_aluguel_mobile/models/financeiro/financeiro.dart';
import 'package:controle_aluguel_mobile/services/casa/casa_services.dart';
import 'package:controle_aluguel_mobile/services/contrato/contrato_services.dart';
import 'package:controle_aluguel_mobile/services/dialogs.dart';
import 'package:controle_aluguel_mobile/services/financeiro/financeiro_services.dart';
import 'package:flutter/material.dart';

class CadFinanceiroPage extends StatefulWidget {
  final Contrato contratoModel;

  const CadFinanceiroPage({
    Key? key,
    required this.contratoModel,
  });

  _CadFinanceiroPageState createState() => _CadFinanceiroPageState();
}

class _CadFinanceiroPageState extends State<CadFinanceiroPage> {
  final TextEditingController _dtPagamento = TextEditingController();
  final TextEditingController _vlrPagamento = TextEditingController();
  final TextEditingController _formaPagamento = TextEditingController();
  final TextEditingController _descricao = TextEditingController();

  FinanceiroServices _financeiroServices = FinanceiroServices();
  ContratoServices _contratoServices = ContratoServices();
  Dialogs _dialogs = Dialogs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Recebimento de Aluguel'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 30, left: 30),
        child: Column(
          children: [
            SizedBox(height: 30),
            TextFormField(
              controller: _dtPagamento,
              decoration: const InputDecoration(
                labelText: 'Data de pagamento',
                hintText: 'DD/MM/AAAA',
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _vlrPagamento,
              decoration: const InputDecoration(
                labelText: 'Valor do pagamento',
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _formaPagamento,
              decoration: const InputDecoration(
                labelText: 'Forma de pagamento',
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _descricao,
              decoration: const InputDecoration(
                labelText: 'Descrição',
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // minimumSize: const Size.fromHeight(50),
                      shape: LinearBorder.bottom(),
                    ),
                    onPressed: () async {
                      await _financeiroServices.save(Financeiro(
                        dtPagamento: _dtPagamento.text,
                        vlrPagamento: _vlrPagamento.text,
                        formaPagamento: _formaPagamento.text,
                        descricao: _descricao.text,
                        idContrato: widget.contratoModel.id,
                      ));
                    }, //chamada do signup do user_services (controller)
                    child: const Text(
                      "Registrar",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    bottom: 15.0,
                  ),
                  alignment: Alignment.bottomRight,
                ),
              ],
            ),
            SizedBox(height: 15)
          ],
        ),
      ),
    );
  }
}
