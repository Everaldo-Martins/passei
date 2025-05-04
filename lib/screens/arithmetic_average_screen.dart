import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArithmeticAverageScreen extends StatefulWidget {
  const ArithmeticAverageScreen({super.key});

  @override
  ArithmeticAverageScreenState createState() => ArithmeticAverageScreenState();
}

class ArithmeticAverageScreenState extends State<ArithmeticAverageScreen> {
  int count = 2;
  double media = 0.0;
  double needed = 0.0;
  List<TextEditingController> notaControllers = List.generate(
    2,
    (index) => TextEditingController(),
  );
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
        notaControllers.removeLast().dispose();
        count--;
      });
    }
  }

  void clearFields() {
    for (var controller in notaControllers) {
      controller.clear();
    }
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

    media = sum / count;
    needed = 0.0;

    if (media >= 4.0 && media < 7.0) {
      needed = ((5 - (0.6 * media)) / 0.4);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(15),
          actions: [
            IconButton(
              icon: const Icon(Icons.close_rounded, size: 28),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          content: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    media >= 7.0
                        ? 'Aprovado'
                        : media >= 4.0
                        ? 'Faz a Final'
                        : 'Reprovado',
                    style: TextStyle(
                      color:
                          media >= 7.0
                              ? const Color(0xFF00FF55)
                              : media >= 4.0
                              ? const Color(0xFFFF9500)
                              : const Color(0xFFFF0000),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('sua média'),
                  const SizedBox(height: 16),
                  Text(media.toStringAsFixed(2)),
                  if (needed > 0.0) ...[
                    const SizedBox(height: 16),
                    const Text('precisa de'),
                    const SizedBox(height: 16),
                    Text(needed.toStringAsFixed(2)),
                    const SizedBox(height: 16),
                    const Text('para ser aprovado.'),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _validateFields() {
    bool isValid = notaControllers.every(
      (controller) => controller.text.isNotEmpty,
    );
    isButtonEnabled.value = isValid;
  }

  @override
  void dispose() {
    for (var controller in notaControllers) {
      controller.removeListener(_validateFields);
      controller.dispose();
    }
    isButtonEnabled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: notaControllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: TextField(
                        maxLines: 1,
                        controller: notaControllers[index],
                        textInputAction: TextInputAction.next,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}'),
                          ),
                        ],
                      ),
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
                      minimumSize: const Size(60, 60),
                      padding: const EdgeInsets.all(0),
                    ),
                    child: const Icon(Icons.add, size: 28),
                  ),
                ],
                if (count > 2) ...[
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: removeNota,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(60, 60),
                      padding: const EdgeInsets.all(0),
                    ),
                    child: const Icon(Icons.remove, size: 28),
                  ),
                ],
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: clearFields,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(60, 60),
                    padding: const EdgeInsets.all(0),
                  ),
                  child: const Icon(Icons.clear_all, size: 28),
                ),
                const SizedBox(width: 16),
                ValueListenableBuilder<bool>(
                  valueListenable: isButtonEnabled,
                  builder: (context, value, child) {
                    return ElevatedButton(
                      onPressed: value ? calculateMedia : null,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(60, 60),
                        padding: const EdgeInsets.all(0),
                      ),
                      child: const Icon(Icons.check, size: 28),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
