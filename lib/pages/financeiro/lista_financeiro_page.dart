// import 'package:controle_aluguel_mobile/models/contrato/contrato.dart';
// import 'package:controle_aluguel_mobile/pages/casa/cad_casa_page.dart';
// import 'package:controle_aluguel_mobile/pages/contratos/cad_contrato_page.dart';
// import 'package:controle_aluguel_mobile/pages/contratos/edit_contrato_page.dart';
// import 'package:controle_aluguel_mobile/pages/home.dart';
// import 'package:controle_aluguel_mobile/services/contrato/contrato_services.dart';
// import 'package:controle_aluguel_mobile/services/dialogs.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';

// ContratoServices _contratoServices = ContratoServices();
// Dialogs _dialogsService = Dialogs();

// class ListaContratoFinanceiro extends StatefulWidget {
//   const ListaContratoFinanceiro({super.key});

//   @override
//   State<ListaContratoFinanceiro> createState() => _TestePageState();
// }

// class _TestePageState extends State<ListaContratoFinanceiro> {
//   @override
//   void didUpdateWidget(covariant ListaContratoFinanceiro oldWidget) {
//     // TODO: implement didUpdateWidget
//     super.didUpdateWidget(oldWidget);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Selecione o Contrato"),
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => HomePage()),
//               );
//             },
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Consumer<ContratoServices>(
//                 builder: (BuildContext context, ContratoServices value,
//                     Widget? child) {
//                   return FutureBuilder<List<Contrato>>(
//                     future: _contratoServices.allContratos(),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasError) {
//                         return const Text('Something went wrong');
//                       }
//                       if (snapshot.data == null) {
//                         return const Text('Sem dados cadastrados');
//                       }

//                       if (snapshot.data != null) {
//                         return ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (context, index) {
//                             // Acessa os campos casa e cliente e fornece um valor padrão caso sejam nulos
//                             final casa =
//                                 snapshot.data![index].casa ?? 'No data';
//                             final cliente =
//                                 snapshot.data![index].cliente ?? 'No data';
//                             final id = snapshot.data![index].id;

//                             return Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Text(casa),
//                                 Text(cliente),
//                                 IconButton(
//                                   icon: const Icon(Icons.check),
//                                   onPressed: () {},
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       } else {
//                         // Se snapshot.data for nulo, exibe uma mensagem de erro ou um indicador de carregamento
//                         return Text('No data available');
//                       }
//                     },
//                   );
//                 },
//               ),
//               Center(
//                 child: ElevatedButton(
//                   style: ButtonStyle(
//                     fixedSize:
//                         MaterialStateProperty.all<Size>(const Size(300, 50)),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CadContratoPage(),
//                       ),
//                     );
//                   },
//                   child: const Text('Novo Pagamento'),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }
