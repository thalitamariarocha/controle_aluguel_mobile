class FinanceiroServices {

  final diaHoje = DateTime.now();


  Future<void> pagar() async {
    await Future.delayed(Duration(seconds: 1));
    print('Pagamento realizado com sucesso!');
  } 

  calculoVencimento(dtVencimento) {

   

   // return DateTime.now().add(Duration(days: 30));
  }

  
}