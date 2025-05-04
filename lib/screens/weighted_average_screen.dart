import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WeightedAverageScreen extends StatefulWidget {
  const WeightedAverageScreen({super.key});

  @override
  WeightedAverageScreenState createState() => WeightedAverageScreenState();
}

class WeightedAverageScreenState extends State<WeightedAverageScreen> {
  int count = 2;
  List<TextEditingController> notaControllers = List.generate(
    2,
    (index) => TextEditingController(),
  );
  List<TextEditingController> pesoControllers = List.generate(
    2,
    (index) => TextEditingController(),
  );
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
    setState(() {
      var newNotaController = TextEditingController();
      var newPesoController = TextEditingController();
      newNotaController.addListener(_validateFields);
      newPesoController.addListener(_validateFields);
      notaControllers.add(newNotaController);
      pesoControllers.add(newPesoController);
      count++;
    });
  }

  void removeNota() {
    if (count > 2) {
      setState(() {
        notaControllers.removeLast().dispose();
        pesoControllers.removeLast().dispose();
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
    double parseLocalDouble(String value) {
      value = value.replaceAll(',', '.');
      return double.tryParse(value.replaceAll(RegExp(r'[^\d\.]'), '')) ?? 0;
    }

    double sum = 0;
    double weightSum = 0;
    double media = 0;
    double needed = 0;

    for (int i = 0; i < count; i++) {
      double nota = parseLocalDouble(notaControllers[i].text);
      double peso = parseLocalDouble(pesoControllers[i].text);

      sum += nota * peso;
      weightSum += peso;
    }

    if (weightSum == 0) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Erro'),
              content: const Text('A soma dos pesos não pode ser zero.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
      return;
    }

    media = sum / weightSum;
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
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 300),
                            child: TextField(
                              controller: notaControllers[index],
                              textInputAction: TextInputAction.next,
                              maxLines: 1,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}'),
                                ),
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Nota',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 100),
                            child: TextField(
                              controller: pesoControllers[index],
                              textInputAction: TextInputAction.next,
                              maxLines: 1,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}'),
                                ),
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Peso',
                                border: OutlineInputBorder(),
                              ),
                            ),
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
                      onPressed: value ? calculateMediaPonderada : null,
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
