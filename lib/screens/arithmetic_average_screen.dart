import 'package:flutter/material.dart';

class ArithmeticAverageScreen extends StatefulWidget {
  const ArithmeticAverageScreen({super.key});

  @override
  ArithmeticAverageScreenState createState() =>
      ArithmeticAverageScreenState();
}

class ArithmeticAverageScreenState extends State<ArithmeticAverageScreen> {
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
    setState(() {
      var newController = TextEditingController();
      newController.addListener(_validateFields);
      notaControllers.add(newController);
      count++;
    });
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
    double parseLocalDouble(String value) {
      value = value.replaceAll(',', '.');
      return double.tryParse(value.replaceAll(RegExp(r'[^\d\.]'), '')) ?? 0;
    }

    double sum = 0;
    int count = notaControllers.length;

    for (var controller in notaControllers) {
      sum += parseLocalDouble(controller.text);
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
                          'sua média',
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
                          media.toStringAsFixed(2),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 46,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF798897),
                          ),
                        ),
                        if (needed > 0) ...[
                          const SizedBox(height: 16),
                          const Text(
                            'precisa de',
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
                            needed.toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 46,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF798897),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'para ser aprovado.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF798897),
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
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: notaControllers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    maxLines: 1,
                    controller: notaControllers[index],
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFFFF6F4),
                      labelText: 'Insira a ${index + 1}ª nota',
                      labelStyle: const TextStyle(
                        fontFamily: 'Ubuntu',
                        color: Color(0xFF798897),
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
              if (count < 4) ...[
                ElevatedButton(
                  onPressed: addNota,
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
                        Icons.add,
                        size: 28,
                      ),
                      SizedBox(height: 2),
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
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: removeNota,
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
                        Icons.remove,
                        size: 28,
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Del',
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 10,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(width: 16),
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
              const SizedBox(width: 16),
              ValueListenableBuilder<bool>(
                valueListenable: isButtonEnabled,
                builder: (context, value, child) {
                  return ElevatedButton(
                    onPressed: value ? calculateMedia : null,
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
