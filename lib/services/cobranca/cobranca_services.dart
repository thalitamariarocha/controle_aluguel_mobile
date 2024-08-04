import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class CobrancaEmailServices {
  String _username = 'thatamariarochavg@gmail.com';
  String _password = 'irto avxo duqh fils';
  final smtpServer =
      gmail('thatamariarochavg@gmail.com', 'irto avxo duqh fils');

  // Email(String username, String password) {
  //   smtpServer = gmail(_username, _password);
  // }

  mensagemCobranca() {
    return 'Prezado(a), \n\n'
        'Estamos enviando este e-mail para lembrá-lo(a) de que o aluguel do imóvel está atrasado. \n\n'
        'O valor devido é de R\$ xxxxx e a data de vencimento foi xxxx. \n\n'
        'Por favor, regularize o pagamento o mais rápido possível. \n\n'
        'Dados de pagamento, \n\n'
        'Banco: 341 - Itaú \n'
        'Agência: 1111 \n'
        'Conta: 1111-6 \n';
  }

  Future<bool> sendMessage(
      String mensagem, String destinatario, String assunto) async {
    final smtpServer =
        gmail('thatamariarochavg@gmail.com', 'irto avxo duqh fils');
    //Configurar a mensagem
    final message = Message()
      ..from = Address('thatamariarochavg@gmail.com', 'Cobrança')
      ..recipients.add(destinatario)
      ..subject = assunto
      ..text = mensagem;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      return true;
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      return false;
    }
  }

  // Future<void> enviarEmail(String assunto, String mensagem) async {
  //   String username = '
  //   String password = '
  //   final smtpServer = gmail(username, password);
  //   final message = Message()
  //     ..from = Address(username)
  //     ..recipients.add('
  //     ..subject = assunto
  //     ..text = mensagem;
  //   try {
  //     final sendReport = await send(message, smtpServer);
  //     print('Message sent: ' + sendReport.toString());
  //   } on MailerException catch (e) {
  //     print('Message not sent. \n' + e.toString());
  //   }
  // }
}
