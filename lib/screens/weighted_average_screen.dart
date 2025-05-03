import 'package:flutter/material.dart';

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

    media = weightSum != 0 ? sum / weightSum : 0;
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
          content: SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close_rounded, size: 28),
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
                          media >= 7.0
                              ? 'Aprovado'
                              : media >= 4.0
                              ? 'Faz a Final'
                              : 'Reprovado',
                          style: TextStyle(
                            color:
                                media >= 7.0
                                    ? Color(0xFF00FF55)
                                    : media >= 4.0
                                    ? Color(0xFFFF9500)
                                    : Color(0xFFFF0000),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text('sua média'),
                        SizedBox(height: 16),
                        Text(media.toStringAsFixed(2)),
                        if (needed > 0.0) ...[
                          SizedBox(height: 16),
                          Text('precisa de'),
                          SizedBox(height: 16),
                          Text(needed.toStringAsFixed(2)),
                          SizedBox(height: 16),
                          Text('para ser aprovado.'),
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
                  child: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: TextField(
                          controller: notaControllers[index],
                          textInputAction: TextInputAction.next,
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: pesoControllers[index],
                          textInputAction: TextInputAction.next,
                          maxLines: 1,
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
                  child: Icon(Icons.add, size: 28),
                ),
              ],
              if (count > 2) ...[
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: removeNota,
                  child: Icon(Icons.remove, size: 28),
                ),
              ],
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: clearFields,
                child: Icon(Icons.clear_all, size: 28),
              ),
              SizedBox(width: 16),
              ValueListenableBuilder<bool>(
                valueListenable: isButtonEnabled,
                builder: (context, value, child) {
                  return ElevatedButton(
                    onPressed: value ? calculateMediaPonderada : null,
                    child: Icon(Icons.check, size: 28),
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
