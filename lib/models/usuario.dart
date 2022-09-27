class Usuario {
  int? id;
  String nomeUsuario;
  String cpfUsuario;
  double rendaMensal;
  double valorMaximoParcela;
  String nomeFiador;
  String cpfFiador;

  Usuario({
    this.id,
    required this.nomeUsuario,
    required this.cpfUsuario,
    required this.rendaMensal,
    required this.valorMaximoParcela,
    required this.nomeFiador,
    required this.cpfFiador,
  });
}
