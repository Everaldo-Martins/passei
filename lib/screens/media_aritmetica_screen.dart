import 'package:flutter/material.dart';

class MediaAritmeticaScreen extends StatefulWidget {
  const MediaAritmeticaScreen({super.key});

  @override
  _MediaAritmeticaScreenState createState() => _MediaAritmeticaScreenState();
}

class _MediaAritmeticaScreenState extends State<MediaAritmeticaScreen> {
  int count = 2;
  double media = 0;
  String mediaResult = '';
  double needed = 0;
  late Color cor;
  List<TextEditingController> notaControllers =
      List.generate(2, (index) => TextEditingController());
  final ValueNotifier<bool> isButtonEnabled = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    for (var controller in notaControllers) {
      controller.addListener(_validateFields);
    }
  }

  void addNota() {
    if (count < 4) {
      setState(() {
        var newController = TextEditingController();
        newController.addListener(_validateFields);
        notaControllers.add(newController);
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
        count--;
      });
    }
  }

  void clearFields() {
    for (var controller in notaControllers) {
      controller.clear();
    }
    setState(() {
      mediaResult = '';
      needed = 0;
    });
    isButtonEnabled.value = false;
  }

  void calculateMedia() {
    double parseBrazilianDouble(String value) {
      value = value.replaceAll(',', '.');
      return double.tryParse(value.replaceAll(RegExp(r'[^\d\.]'), '')) ?? 0;
    }

    double sum = 0;
    int count = notaControllers.length;

    for (var controller in notaControllers) {
      sum += parseBrazilianDouble(controller.text);
    }

    double media = sum / count;

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
                            fontFamily: 'Ubuntu',
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
        notaControllers.every((controller) => controller.text.isNotEmpty);
    isButtonEnabled.value = isValid;
  }

  @override
  void dispose() {
    for (var controller in notaControllers) {
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
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: addNota,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF3B3F),
                  foregroundColor: const Color(0xFFF9F9F9),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.add)
                  ],
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: removeNota,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF3B3F),
                  foregroundColor: const Color(0xFFF9F9F9),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.remove)
                  ],
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: clearFields,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF3B3F),
                  foregroundColor: const Color(0xFFF9F9F9),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.clear)
                  ],
                ),
              ),
              const SizedBox(width: 16),
              ValueListenableBuilder<bool>(
                valueListenable: isButtonEnabled,
                builder: (context, value, child) {
                  return ElevatedButton(
                    onPressed: value ? calculateMedia : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF3B3F),
                      foregroundColor: const Color(0xFFF9F9F9),
                      disabledBackgroundColor: const Color(0x99FF3B3F),
                      disabledForegroundColor: const Color(0x66F9F9F9),
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.check)
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