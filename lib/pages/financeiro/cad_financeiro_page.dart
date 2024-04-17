import 'package:controle_aluguel_mobile/services/casa/casa_services.dart';
import 'package:controle_aluguel_mobile/services/contrato/contrato_services.dart';
import 'package:controle_aluguel_mobile/services/dialogs.dart';
import 'package:flutter/material.dart';

class CadFinanceiroPage extends StatefulWidget {
  @override
  _CadFinanceiroPageState createState() => _CadFinanceiroPageState();
}

class _CadFinanceiroPageState extends State<CadFinanceiroPage> {
  final TextEditingController _dtPagamento = TextEditingController();
  final TextEditingController _vlrPagamento = TextEditingController();
  final TextEditingController _formaPagamento = TextEditingController();
  final TextEditingController _descricao = TextEditingController();
  CasaServices _casaServices = CasaServices();
  ContratoServices _contratoServices = ContratoServices();
  Dialogs _dialogs = Dialogs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lançamento de Aluguel'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 30, left: 30),
        child: Column(
          children: [
            SizedBox(height: 30),
            const Center(
              child: Text(
                "Selecione o contrato",
              ),
            ),
            FutureBuilder<List<String>>(
              future: _contratoServices.loadNamesFromFirebase()
                  as Future<List<String>>?,
              builder:
                  (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Erro ao carregar os nomes');
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return DropdownButton<String>(
                    alignment: Alignment.bottomCenter,
                    borderRadius: BorderRadius.circular(10),
                    value: _casaServices.selectedCasa,
                    onChanged: (String? newValue) {
                      setState(() {
                        _casaServices.selectedCasa = newValue!;
                      });
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // minimumSize: const Size.fromHeight(50),
                      shape: LinearBorder.bottom(),
                    ),
                    onPressed:
                        () async {}, //chamada do signup do user_services (controller)
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
