import 'package:flutter/material.dart';
import 'package:sprint1_cadastro/pages/cadastro_usuarios_page.dart';
import 'package:sprint1_cadastro/pages/clientes_detalhes_page.dart';
import 'package:sprint1_cadastro/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/usuario-cadastro': (context) => UsuarioCadastroPage(),
        '/usuario-detalhes': (context) => const ClientesDetalhesPage(),
      },
      initialRoute: '/',
    );
  }
}
