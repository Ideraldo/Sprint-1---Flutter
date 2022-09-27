import 'package:flutter/material.dart';
import 'package:sprint1_cadastro/components/usuario_list_item.dart';
import 'package:sprint1_cadastro/models/usuario.dart';
import 'package:sprint1_cadastro/repository/usuario_repository.dart';

class ClientesListaPage extends StatefulWidget {
  ClientesListaPage({Key? key}) : super(key: key);

  @override
  State<ClientesListaPage> createState() => _ClientesListaPage();
}

class _ClientesListaPage extends State<ClientesListaPage> {
  final _futureClientes = UsuarioRepository().listarUsuarios();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clientes')),
      body: FutureBuilder<List<Usuario>>(
          future: _futureClientes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              final usuarios = snapshot.data ?? [];
              return ListView.separated(
                itemCount: usuarios.length,
                itemBuilder: (context, index) {
                  final usuario = usuarios[index];
                  return ClientesListaItem(usuario: usuario);
                },
                separatorBuilder: (context, index) => const Divider(),
              );
            }
            return Container();
          }),
    );
  }
}
