import 'dart:typed_data';

import 'package:controle_aluguel_mobile/models/contrato/contrato.dart';
import 'package:controle_aluguel_mobile/services/casa/casa_services.dart';
import 'package:controle_aluguel_mobile/services/contrato/contrato_services.dart';
import 'package:controle_aluguel_mobile/services/dialogs.dart';
import 'package:controle_aluguel_mobile/services/users/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:multi_masked_formatter/multi_masked_formatter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditContratoPage extends StatefulWidget {
  final Contrato contratoModel;
  String nomeCasa;
  String nomeCliente;

  EditContratoPage(
      {Key? key,
      required this.contratoModel,
      required this.nomeCasa,
      required this.nomeCliente});

  @override
  State<EditContratoPage> createState() => _EditContratoPageState();
}

class _EditContratoPageState extends State<EditContratoPage> {
  //_EditContratoPageState(this.idContrato);
  //final String idContrato; // Variável local para armazenar o id
  final TextEditingController _dtInicioContrato = TextEditingController();
  final TextEditingController _dtFinalContrato = TextEditingController();
  final TextEditingController _dtVencimento = TextEditingController();
  final TextEditingController _tempoContrato = TextEditingController();
  final TextEditingController _valorContrato = TextEditingController();
  final ContratoServices _contratoServices = ContratoServices();
  final CasaServices _casaServices = CasaServices();
  final UserServices _userServices = UserServices();
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  final Dialogs _dialogs = Dialogs();
  String nomeCasa = '';
  String nomeCliente = '';

  late List<String> _names = [];

  @override
  void initState() {
    super.initState();

    carregar(widget.contratoModel);
  }

  carregar(Contrato contratoModel) async {
    _dtInicioContrato.text = contratoModel.dtInicioContrato!;
    _dtFinalContrato.text = contratoModel.dtFinalContrato!;
    _tempoContrato.text = contratoModel.tempoContrato!;
    _valorContrato.text = contratoModel.valorMensal!;
    _dtVencimento.text = contratoModel.dtVencimento!;
  }

  @override
  Widget build(BuildContext context) {
    String nomeCasa = widget.nomeCasa;
    String nomeCliente = widget.nomeCliente;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contrato"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),

            Center(
              child: Text('Cliente: $nomeCliente'),
            ),

            // FutureBuilder<List<String>>(
            //   future: _userServices.loadNamesFromFirebase()
            //       as Future<List<String>>?,
            //   builder:
            //       (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            //     if (snapshot.hasError) {
            //       return const Text('Erro ao carregar os nomes');
            //     }

            //     if (snapshot.connectionState == ConnectionState.done) {
            //       return DropdownButton<String>(
            //         alignment: Alignment.bottomCenter,
            //         borderRadius: BorderRadius.circular(10),
            //         value: _userServices.selectedCliente,
            //         onChanged: (String? newValue) {
            //           setState(() {
            //             _userServices.selectedCliente = newValue!;
            //           });
            //         },
            //         items: snapshot.data!.map((String value) {
            //           return DropdownMenuItem<String>(
            //             value: value,
            //             child: Text(value),
            //           );
            //         }).toList(),
            //       );
            //     }

            //     return const CircularProgressIndicator();
            //   },
            // ),

            //------------------------------------------------------------------

            Center(
              child: Text(
                'Casa: $nomeCasa',
              ),
            ),

            // FutureBuilder<List<String>>(
            //   future: _casaServices.loadNamesFromFirebase()
            //       as Future<List<String>>?,
            //   builder:
            //       (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            //     if (snapshot.hasError) {
            //       return const Text('Erro ao carregar os nomes');
            //     }

            //     if (snapshot.connectionState == ConnectionState.done) {
            //       return DropdownButton<String>(
            //         alignment: Alignment.bottomCenter,
            //         borderRadius: BorderRadius.circular(10),
            //         value: _casaServices.selectedCasa,
            //         onChanged: (String? newValue) {
            //           setState(() {
            //             _casaServices.selectedCasa = newValue!;
            //           });
            //         },
            //         items: snapshot.data!.map((String value) {
            //           return DropdownMenuItem<String>(
            //             value: value,
            //             child: Text(value),
            //           );
            //         }).toList(),
            //       );
            //     }

            //     return const CircularProgressIndicator();
            //   },
            // ),

            //------------------------------------------------------------------
            SizedBox(height: 30),
            TextFormField(
              controller: _tempoContrato,
              decoration: const InputDecoration(
                labelText: "tempo de contrato (em meses)",
              ),
              keyboardType: TextInputType.number,
            ),
            //--------------------------------------------------------------------------
            SizedBox(height: 30),
            TextFormField(
              controller: _dtInicioContrato,
              decoration: const InputDecoration(
                labelText: 'Data de Inicio do contrato',
                hintText: 'DD/MM/AAAA',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              //keyboardType: TextInputType.datetime,
              inputFormatters: [
                MultiMaskedTextInputFormatter(
                  masks: ['DD/MM/YYYY'],
                  separator: '/',
                ),
              ],
            ),
            //------------------------------------------------------------------
            const SizedBox(height: 30),
            TextFormField(
              controller: _dtFinalContrato,
              decoration: const InputDecoration(
                labelText: 'Data Final do contrato',
                hintText: 'DD/MM/AAAA',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              //keyboardType: TextInputType.datetime,
              inputFormatters: [
                MultiMaskedTextInputFormatter(
                  masks: ['DD/MM/YYYY'],
                  separator: '/',
                ),
              ],
            ),
            //---------------------------------------------------------------------------
            const SizedBox(height: 30),
            TextFormField(
              controller: _dtVencimento,
              decoration: const InputDecoration(
                labelText: "dia do vencimento do aluguel",
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),

            //---------------------------------------------------------------------------

            TextFormField(
              controller: _valorContrato,
              decoration: const InputDecoration(
                labelText: "valor mensal do aluguel",
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),

            //-------------------------------------------------------------------------------

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
                      if (await _contratoServices.atualizarContrato(
                        widget.contratoModel.id!,
                        widget.contratoModel.cpfCliente!,
                        widget.contratoModel.idCasa!,
                        _dtInicioContrato.text,
                        _dtFinalContrato.text,
                        _tempoContrato.text,
                        _valorContrato.text,
                        _dtVencimento.text,
                      )) {
                        // _dialogs.showSuccessDialog(
                        //     context, 'atualizado com sucesso!');

                        Navigator.of(context).pop();
                      } else {
                        // ignore: use_build_context_synchronously
                        _dialogs.showErrorDialog(
                            context, 'erro, favor repetir');
                      }
                    }, //chamada do signup do user_services (controller)
                    child: const Text(
                      "Salvar",
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
