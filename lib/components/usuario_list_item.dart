import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprint1_cadastro/models/usuario.dart';
import 'package:sprint1_cadastro/util/helper_colors.dart';
import 'package:sprint1_cadastro/util/helper_icons.dart';

class ClientesListaItem extends StatelessWidget {
  final Usuario usuario;
  const ClientesListaItem({Key? key, required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(usuario.nomeUsuario),
      subtitle: Text(
        '${usuario.cpfUsuario}',
        style: const TextStyle(
            fontWeight: FontWeight.w500, fontSize: 15, color: Colors.green),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/usuario-detalhes', arguments: usuario);
      },
    );
  }
}
