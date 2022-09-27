import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';

import '../models/usuario.dart';
import '../repository/usuario_repository.dart';

import 'package:cpf_cnpj_validator/cpf_validator.dart';

class UsuarioCadastroPage extends StatefulWidget {
  Usuario? usuarioParaEdicao;
  UsuarioCadastroPage({Key? key, this.usuarioParaEdicao}) : super(key: key);

  @override
  State<UsuarioCadastroPage> createState() => _UsuarioCadastroPageState();
}

class _UsuarioCadastroPageState extends State<UsuarioCadastroPage> {
  final _usuarioRepository = UsuarioRepository();

  final _nomeUsuarioController = TextEditingController();
  final _cpfUsuarioController = TextEditingController();

  final _rendaMensalController = MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$');

  final _valorMaximoParcelaController = MoneyMaskedTextController(
      decimalSeparator: ',', thousandSeparator: '.', leftSymbol: 'R\$');

  final _nomeFiadorController = TextEditingController();
  final _cpfFiadorController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final usuario = widget.usuarioParaEdicao;
    if (usuario != null) {
      _nomeUsuarioController.text = usuario.nomeUsuario;
      _cpfUsuarioController.text = usuario.cpfUsuario;
      _rendaMensalController.text = NumberFormat.simpleCurrency(locale: 'pt_BR')
          .format(usuario.rendaMensal);
      _valorMaximoParcelaController.text =
          NumberFormat.simpleCurrency(locale: 'pt_BR')
              .format(usuario.valorMaximoParcela);
      _nomeFiadorController.text = usuario.nomeFiador;
      _cpfFiadorController.text = usuario.cpfFiador;
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Usuario para analise'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildNomeUsuario(),
                const SizedBox(height: 20),
                _buildCpfUsuario(),
                const SizedBox(height: 20),
                _buildRendaMensal(),
                const SizedBox(height: 20),
                _buildValorMaximoParcela(),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                _buildNomeFiador(),
                const SizedBox(height: 20),
                _buildCpfFiador(),
                const SizedBox(height: 20),
                _buildButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _buildButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Cadastrar'),
        ),
        onPressed: () async {
          final isValid = _formKey.currentState!.validate();
          if (isValid) {
            final nomeUsuario = _nomeUsuarioController.text;

            final cpfUsuario = _cpfUsuarioController.text;

            final rendaMensal = NumberFormat.currency(locale: 'pt_BR')
                .parse(_rendaMensalController.text.replaceAll('R\$', ''))
                .toDouble();
            final valorMaximoParcela = NumberFormat.currency(locale: 'pt_BR')
                .parse(_valorMaximoParcelaController.text.replaceAll('R\$', ''))
                .toDouble();

            final nomeFiador = _nomeFiadorController.text;

            final cpfFiador = _cpfFiadorController.text;

            final usuario = Usuario(
                nomeUsuario: nomeUsuario,
                cpfUsuario: cpfUsuario,
                rendaMensal: rendaMensal,
                valorMaximoParcela: valorMaximoParcela,
                nomeFiador: nomeFiador,
                cpfFiador: cpfFiador);

            try {
              if (widget.usuarioParaEdicao != null) {
                usuario.id = widget.usuarioParaEdicao!.id;
                await _usuarioRepository.editarUsuario(usuario);
              } else {
                await _usuarioRepository.cadastrarUsuario(usuario);
              }

              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Usuario cadastrado com sucesso'),
              ));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Falha ao cadastrar usuário'),
              ));
            }
          }
        },
      ),
    );
  }

  TextFormField _buildNomeUsuario() {
    return TextFormField(
      controller: _nomeUsuarioController,
      decoration: const InputDecoration(
        hintText: 'Informe o nome do usuario',
        labelText: 'Nome do usuario',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.text_fields),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe o nome';
        }
        if (value.length < 5 || value.length > 30) {
          return 'O nome deve entre 5 e 80 caracteres';
        }
        return null;
      },
    );
  }

  TextFormField _buildNomeFiador() {
    return TextFormField(
      controller: _nomeFiadorController,
      decoration: const InputDecoration(
        hintText: 'Informe o nome do fiador',
        labelText: 'Nome do fiador',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.text_fields),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe o nome';
        }
        if (value.length < 5 || value.length > 30) {
          return 'O nome deve entre 5 e 80 caracteres';
        }
        return null;
      },
    );
  }

  TextFormField _buildCpfUsuario() {
    return TextFormField(
      controller: _cpfUsuarioController,
      decoration: const InputDecoration(
        hintText: 'Informe o CPF',
        labelText: 'CPF',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.document_scanner),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe o CPF do usuario';
        }
        if (!CPFValidator.isValid(CPFValidator.format(value))) {
          return 'Informe um cpf valido!';
        }
        return null;
      },
    );
  }

  TextFormField _buildCpfFiador() {
    return TextFormField(
      controller: _cpfFiadorController,
      decoration: const InputDecoration(
        hintText: 'Informe o CPF',
        labelText: 'CPF',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.document_scanner),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe o CPF do fiador';
        }
        if (!CPFValidator.isValid(CPFValidator.format(value))) {
          return 'Informe um cpf valido!';
        }
        return null;
      },
    );
  }

  TextFormField _buildRendaMensal() {
    return TextFormField(
      controller: _rendaMensalController,
      decoration: const InputDecoration(
        hintText: 'Informe o valor da renda mensal',
        labelText: 'Renda mensal',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.money),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe uma renda';
        }
        final valor = NumberFormat.currency(locale: 'pt_BR')
            .parse(_rendaMensalController.text.replaceAll('R\$', ''));
        if (valor <= 0) {
          return 'Informe um valor maior que zero';
        }

        return null;
      },
    );
  }

  TextFormField _buildValorMaximoParcela() {
    return TextFormField(
      controller: _valorMaximoParcelaController,
      decoration: const InputDecoration(
        hintText: 'Informe o valor máximo que pode ser pago mensalmente',
        labelText: 'Parcela máxima mensal',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.money),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um valor';
        }
        final valor = NumberFormat.currency(locale: 'pt_BR')
            .parse(_rendaMensalController.text.replaceAll('R\$', ''));
        if (valor <= 0) {
          return 'Informe um valor maior que zero';
        }

        return null;
      },
    );
  }
}
