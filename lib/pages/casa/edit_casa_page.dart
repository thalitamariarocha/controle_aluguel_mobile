import 'package:controle_aluguel_mobile/models/casa/casa.dart';
import 'package:controle_aluguel_mobile/services/casa/casa_services.dart';
import 'package:controle_aluguel_mobile/services/dialogs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditCasaPage extends StatefulWidget {
  //String idCasa;
  final Casa casa;

  EditCasaPage({
    Key? key,
    required this.casa,
  });

  @override
  State<EditCasaPage> createState() => _EditCasaPageState();
}

class _EditCasaPageState extends State<EditCasaPage> {
  final TextEditingController _endereco = TextEditingController();
  final TextEditingController _nome = TextEditingController();
  CasaServices _casaServices = CasaServices();
  Dialogs _dialogs = Dialogs();
  final ImagePicker _picker = ImagePicker();
  late String urlImg = '';

  @override
  void initState() {
    super.initState();
    carregar(widget.casa);
  }

  void carregar(Casa casa) {
    _endereco.text = casa.endereco!;
    _nome.text = casa.nome!;
    urlImg = casa.image!;
  }

  bool newImage() {
    if (_casaServices.webImage == null ||
        _casaServices.webImage.isEmpty ||
        _casaServices.webImage.length < 9) {
      return false;
    }
    return true;
  }

  closeScreen() {
    _dialogs.showSuccessDialog(context, "cadastro salvo!");

    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Imóvel"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 50, left: 50),
        child: Column(
          children: [
            SizedBox(height: 30),
            TextFormField(
              controller: _nome,
              decoration: const InputDecoration(
                labelText: "Nome do empreendimento",
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _endereco,
              decoration: const InputDecoration(
                labelText: "Endereço completo",
              ),
            ),
            SizedBox(height: 10),

            //-------------------------------------------------------------------------------
            // carregar imagem

            SizedBox(height: 30),
            const Row(
              children: [
                Text('Insira abaixo a imagem do imóvel: '),
              ],
            ),
            const SizedBox(height: 15),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: LinearBorder.bottom(),
              ),
              onPressed: () async {
                if (kIsWeb) {
                  await _casaServices.pickAndUploadImage();
                } else {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(Icons.photo),
                          title: Text('Galeria'),
                          onTap: () async {
                            await _casaServices.pickAndUploadImage();
                            Navigator.of(context).pop();
                            //CloseButton();
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.camera),
                          title: Text('Câmera'),
                          onTap: () async {
                            _casaServices.pickImageFromCamera();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                }

                // await _casaServices.pickAndUploadImage();
              },
              child: const Text('selecione aqui'),
            ),

            const SizedBox(height: 30),

            //Image(image: _casaServices.previewImage()),

            const SizedBox(height: 50),

            //------------------------------------------------------------------

            Row(
              //botao voltar e cadastrar
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child:
                      //botao registrar
                      ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: LinearBorder.bottom(),
                    ),
                    onPressed: () async {
                      if (_nome.text.isEmpty || _endereco.text.isEmpty) {
                        _dialogs.showErrorDialog(
                            context, 'todos os campos devem ser preenchidos');
                        return;
                      }

                      if (await _casaServices.atualizaCasa(
                              widget.casa.id!,
                              _nome.text,
                              _endereco.text,
                              newImage() ? _casaServices.webImage : urlImg,
                              widget.casa.alugada!) ==
                          true) {
                        closeScreen();
                      } else {
                        debugPrint("erro, favor repetir");
                      }
                    },
                    child: const Text(
                      "Salvar",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 15.0,
              ),
              alignment: Alignment.bottomRight,
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
