import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprint1_cadastro/models/usuario.dart';

class ClientesDetalhesPage extends StatelessWidget {
  const ClientesDetalhesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usuario = ModalRoute.of(context)!.settings.arguments as Usuario;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(usuario.nomeUsuario),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text('Nome do cliente'),
              subtitle: Text(usuario.nomeUsuario),
            ),
            ListTile(
              title: const Text('CPF do cliente'),
              subtitle: Text(usuario.cpfUsuario),
            ),
            ListTile(
              title: const Text('Renda mensal'),
              subtitle: Text(NumberFormat.simpleCurrency(locale: 'pt_BR')
                  .format(usuario.rendaMensal)),
            ),
            ListTile(
              title: const Text('Valor maximo de parcela mensal'),
              subtitle: Text(NumberFormat.simpleCurrency(locale: 'pt_BR')
                  .format(usuario.valorMaximoParcela)),
            ),
            ListTile(
              title: const Text('Nome do Fiador'),
              subtitle: Text(usuario.nomeFiador),
            ),
            ListTile(
              title: const Text('CPF do Fiador'),
              subtitle: Text(usuario.cpfFiador),
            ),
          ],
        ),
      ),
    );
  }
}
