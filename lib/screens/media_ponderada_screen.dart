import 'package:flutter/material.dart';

class MediaPonderadaScreen extends StatefulWidget {
  const MediaPonderadaScreen({super.key});

  @override
  _MediaPonderadaScreenState createState() => _MediaPonderadaScreenState();
}

class _MediaPonderadaScreenState extends State<MediaPonderadaScreen> {
  int count = 2;
  List<TextEditingController> notaControllers =
      List.generate(2, (index) => TextEditingController());
  List<TextEditingController> pesoControllers =
      List.generate(2, (index) => TextEditingController());
  String mediaResult = '';
  final ValueNotifier<bool> isButtonEnabled = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    for (var controller in notaControllers) {
      controller.addListener(_validateFields);
    }
    for (var controller in pesoControllers) {
      controller.addListener(_validateFields);
    }
  }

  void addNota() {
    if (count < 4) {
      setState(() {
        var newNotaController = TextEditingController();
        var newPesoController = TextEditingController();
        newNotaController.addListener(_validateFields);
        newPesoController.addListener(_validateFields);
        notaControllers.add(newNotaController);
        pesoControllers.add(newPesoController);
        count++;
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            content: Text(
              'O limite máximo é de 4 campos.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFFF3B3F),
                fontFamily: 'Ubuntu',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
      );
    }
  }

  void removeNota() {
    if (count > 2) {
      setState(() {
        notaControllers.removeLast();
        pesoControllers.removeLast();
        count--;
      });
    }
  }

  void clearFields() {
    for (var controller in notaControllers) {
      controller.clear();
    }
    for (var controller in pesoControllers) {
      controller.clear();
    }
    setState(() {
      mediaResult = '';
    });
    isButtonEnabled.value = false;
  }

  void calculateMediaPonderada() {
    double parseBrazilianDouble(String value) {
      value = value.replaceAll(',', '.');
      return double.tryParse(value.replaceAll(RegExp(r'[^\d\.]'), '')) ?? 0;
    }

    double sum = 0;
    double weightSum = 0;
    double media = 0;
    double needed = 0;
    late Color cor;

    for (int i = 0; i < count; i++) {
      double nota = parseBrazilianDouble(notaControllers[i].text);
      double peso = parseBrazilianDouble(pesoControllers[i].text);

      sum += nota * peso;
      weightSum += peso;
    }

    media = weightSum != 0 ? sum / weightSum : 0;

    setState(() {
      if (media >= 7.0) {
        mediaResult = 'Aprovado';
        cor = const Color(0xFF00FF55);
        needed = 0;
      } else if (media >= 4.0) {
        needed = ((5 - (0.6 * media)) / 0.4);
        mediaResult = 'Faz a Final';
        cor = const Color(0xFFFF9500);
      } else {
        mediaResult = 'Reprovado';
        cor = const Color(0xFFFF0000);
        needed = 0;
      }
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF9F9F9),
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
                          mediaResult,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: cor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Média',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF686868),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          media.toStringAsFixed(2),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 46,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF686868),
                          ),
                        ),
                        if (needed > 0) ...[
                          const SizedBox(height: 16),
                          const Text(
                            'Precisando',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF686868),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            needed.toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 46,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF686868),
                            ),
                          ),
                        ],
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

  void _validateFields() {
    bool isValid =
        notaControllers.every((controller) => controller.text.isNotEmpty) &&
            pesoControllers.every((controller) => controller.text.isNotEmpty);
    isButtonEnabled.value = isValid;
  }

  @override
  void dispose() {
    for (var controller in notaControllers) {
      controller.removeListener(_validateFields);
      controller.dispose();
    }
    for (var controller in pesoControllers) {
      controller.removeListener(_validateFields);
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: notaControllers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: TextField(
                          controller: notaControllers[index],
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Insira a ${index + 1}ª nota',
                            labelStyle: const TextStyle(
                              fontFamily: 'Ubuntu',
                              color: Color(0xFF686868),
                            ),
                            floatingLabelStyle: const TextStyle(
                              fontFamily: 'Ubuntu',
                              color: Color(0xFFFF3B3F),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFF3B3F),
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFF3B3F),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: pesoControllers[index],
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'Peso',
                            labelStyle: TextStyle(
                              fontFamily: 'Ubuntu',
                              color: Color(0xFF686868),
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
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (count < 4) ...[
                ElevatedButton(
                  onPressed: addNota,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF3B3F),
                    foregroundColor: const Color(0xFFF9F9F9),
                    elevation: 6,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add,
                        size: 26,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Add',
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 10,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
              if (count > 2) ...[
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: removeNota,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF3B3F),
                    foregroundColor: const Color(0xFFF9F9F9),
                    elevation: 6,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.remove,
                        size: 26,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Remover',
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 10,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: clearFields,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF3B3F),
                  foregroundColor: const Color(0xFFF9F9F9),
                  elevation: 6,
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
                      size: 26,
                    ),
                    SizedBox(height: 4),
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
                    onPressed: value ? calculateMediaPonderada : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF3B3F),
                      foregroundColor: const Color(0xFFF9F9F9),
                      disabledBackgroundColor: const Color(0x99FF3B3F),
                      disabledForegroundColor: const Color(0x66F9F9F9),
                      elevation: 6,
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
                          size: 26,
                        ),
                        SizedBox(height: 4),
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
