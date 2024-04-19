class Financeiro {
  String? id;
  String? idContrato;
  String? dtPagamento;
  String? vlrPagamento;
  String? formaPagamento;
  String? descricao;

  Financeiro({
    this.id,
    this.idContrato,
    this.dtPagamento,
    this.vlrPagamento,
    this.formaPagamento,
    this.descricao,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idContrato': idContrato,
      'dtPagamento': dtPagamento,
      'vlrPagamento': vlrPagamento,
      'formaPagamento': formaPagamento,
      'descricao': descricao,
    };
  }

  Map<String, dynamic> toJsonid() {
    return {
      'id': id,
    };
  }
}
