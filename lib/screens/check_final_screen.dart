import 'package:flutter/material.dart';

class CheckFinalScreen extends StatefulWidget {
  const CheckFinalScreen({super.key});

  @override
  CheckFinalScreenState createState() => CheckFinalScreenState();
}

class CheckFinalScreenState extends State<CheckFinalScreen> {
  TextEditingController mediaController = TextEditingController();
  TextEditingController provaFinalController = TextEditingController();
  final ValueNotifier<bool> isButtonEnabled = ValueNotifier<bool>(false);
  String finalResult = '';
  String mediaResult = '';
  late Color cor;

  @override
  void initState() {
    super.initState();
    mediaController.addListener(_validateFields);
    provaFinalController.addListener(_validateFields);
  }

  void verifyFinal() {
    double parseLocalDouble(String value) {
      value = value.replaceAll(',', '.');
      return double.tryParse(value.replaceAll(RegExp(r'[^\d\.]'), '')) ?? 0;
    }

    double media = parseLocalDouble(mediaController.text);
    double provaFinal = parseLocalDouble(provaFinalController.text);

    double finalMedia = ((media * 6) + (provaFinal * 4)) / 10;

    setState(() {
      if (finalMedia >= 5.0) {
        finalResult = 'Aprovado';
        mediaResult = finalMedia.toStringAsFixed(2);
        cor = const Color(0xFF00FF55);
      } else {
        finalResult = 'Reprovado';
        mediaResult = finalMedia.toStringAsFixed(2);
        cor = const Color(0xFFFF0000);
      }
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFF6F4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(15),
          content: SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      size: 28,
                    ),
                    color: const Color(0xFFFF3B3F),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 50,
                    horizontal: 20,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          finalResult,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: cor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'com média',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF798897),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          mediaResult,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 46,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF798897),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void clearFields() {
    mediaController.clear();
    provaFinalController.clear();
    setState(() {
      finalResult = '';
      mediaResult = '';
    });
    isButtonEnabled.value = false;
  }

  void _validateFields() {
    bool isValid =
        mediaController.text.isNotEmpty && provaFinalController.text.isNotEmpty;
    isButtonEnabled.value = isValid;
  }

  @override
  void dispose() {
    mediaController.removeListener(_validateFields);
    provaFinalController.removeListener(_validateFields);
    mediaController.dispose();
    provaFinalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                TextField(
                  controller: mediaController,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFFFF6F4),
                    labelText: 'Média',
                    labelStyle: TextStyle(
                      fontFamily: 'Ubuntu',
                      color: Color(0xFF798897),
                    ),
                    floatingLabelStyle: TextStyle(
                      fontFamily: 'Ubuntu',
                      color: Color(0xFFFF3B3F),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFFF3B3F),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFFF3B3F),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: provaFinalController,
                  textInputAction: TextInputAction.done,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFFFF6F4),
                    labelText: 'Prova Final',
                    labelStyle: TextStyle(
                      fontFamily: 'Ubuntu',
                      color: Color(0xFF798897),
                    ),
                    floatingLabelStyle: TextStyle(
                      fontFamily: 'Ubuntu',
                      color: Color(0xFFFF3B3F),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFFF3B3F),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFFF3B3F),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: clearFields,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFF6F4),
                  foregroundColor: const Color(0xFFFF3B3F),
                  disabledBackgroundColor: const Color(0xAAFFF6F4),
                  disabledForegroundColor: const Color(0xAAFF3B3F),
                  elevation: 8,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 12,
                  ),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.clear_all,
                      size: 28,
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Limpar',
                      style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 10,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              ValueListenableBuilder<bool>(
                valueListenable: isButtonEnabled,
                builder: (context, value, child) {
                  return ElevatedButton(
                    onPressed: value ? verifyFinal : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFF6F4),
                      foregroundColor: const Color(0xFFFF3B3F),
                      disabledBackgroundColor: const Color(0xAAFFF6F4),
                      disabledForegroundColor: const Color(0xAAFF3B3F),
                      elevation: 8,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check,
                          size: 28,
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Enviar',
                          style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 10,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}