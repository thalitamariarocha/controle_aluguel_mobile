import 'package:controle_aluguel_mobile/models/contrato/contrato.dart';
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
            )
          ],
        ),
      ),
    );
  }
}
