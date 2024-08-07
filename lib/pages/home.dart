// ignore_for_file: use_build_context_synchronously

import 'package:controle_aluguel_mobile/pages/casa/lista_casa_page.dart';

import 'package:controle_aluguel_mobile/pages/clientes/lista_cliente_page.dart';
import 'package:controle_aluguel_mobile/pages/cobranca/cobranca_email_page.dart';

import 'package:controle_aluguel_mobile/pages/contratos/lista_contrato_page.dart';
import 'package:controle_aluguel_mobile/pages/financeiro/cad_financeiro_page.dart';
import 'package:controle_aluguel_mobile/pages/financeiro/lista_financeiro_page.dart';
import 'package:controle_aluguel_mobile/pages/login/login_page.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _LoginPageState();

  build(BuildContext context) {
    // Obtém o tamanho da largura da tela
    double screenWidth = MediaQuery.of(context).size.width;

    // Define o tamanho do ícone com base na largura da tela
    double iconSize = screenWidth / 5; // Ajuste conforme necessário
  }
}

class _LoginPageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.manage_accounts_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Menu da Conta'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // ListTile(
                        //   title: Text("Minha Conta"),
                        //   onTap: () {
                        //     // Adicione a ação que você deseja executar ao clicar em "Minha Conta"
                        //     Navigator.pop(context);
                        //   },
                        // ),
                        ListTile(
                          title: Text("Sair"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(4, 121, 9, 1),
              ),
              child: Icon(
                Icons.blur_on,
                color: Colors.white,
                size: 100,
              ),
            ),
            ListTile(
              title: Text('Inquilinos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaCliente(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Imóveis'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaCasa(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Contratos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaContrato(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Gerenciar Alugueis'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaFinanceiro(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Enviar Email'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CobrancaEmailPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: TextDirection.ltr,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.house),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListaCasa(),
                          ),
                        );
                      },
                      iconSize: (MediaQuery.of(context).size.width) / 8,
                    ),
                    const Text('Imóveis'),
                  ],
                ),
                const SizedBox(
                  width: 60,
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.man),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListaCliente(),
                          ),
                        );
                      },
                      iconSize: (MediaQuery.of(context).size.width) / 8,
                    ),
                    const Text('Inquilinos'),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: TextDirection.ltr,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.text_snippet_outlined),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListaContrato(),
                          ),
                        );
                      },
                      iconSize: (MediaQuery.of(context).size.width) / 8,
                    ),
                    const Text('Contratos'),
                  ],
                ),
                const SizedBox(
                  width: 60,
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.attach_money),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListaFinanceiro(),
                          ),
                        );
                      },
                      iconSize: (MediaQuery.of(context).size.width) / 8,
                    ),
                    const Text('Alugueis'),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: TextDirection.ltr,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.email),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CobrancaEmailPage(),
                          ),
                        );
                      },
                      iconSize: (MediaQuery.of(context).size.width) / 8,
                    ),
                    const Text('Email'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      color: Colors.white,
                      icon: const Icon(Icons.email),
                      onPressed: () {},
                      iconSize: (MediaQuery.of(context).size.width) / 8,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 60,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
