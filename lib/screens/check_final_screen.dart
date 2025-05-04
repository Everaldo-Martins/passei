import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckFinalScreen extends StatefulWidget {
  const CheckFinalScreen({super.key});

  @override
  CheckFinalScreenState createState() => CheckFinalScreenState();
}

class CheckFinalScreenState extends State<CheckFinalScreen> {
  TextEditingController mediaController = TextEditingController();
  TextEditingController provaFinalController = TextEditingController();
  final ValueNotifier<bool> isButtonEnabled = ValueNotifier<bool>(false);

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

    if (media < 0 || media > 10 || provaFinal < 0 || provaFinal > 10) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Erro'),
              content: const Text('As notas devem estar entre 0 e 10.'),
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

    double finalMedia = ((media * 6) + (provaFinal * 4)) / 10;

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
                    finalMedia >= 5.0 ? 'Aprovado' : 'Reprovado',
                    style: TextStyle(
                      color:
                          finalMedia >= 5.0
                              ? const Color(0xFF00FF55)
                              : const Color(0xFFFF0000),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('com média'),
                  const SizedBox(height: 16),
                  Text(finalMedia.toStringAsFixed(2)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void clearFields() {
    mediaController.clear();
    provaFinalController.clear();
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
    isButtonEnabled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Insira a média e a nota da prova final',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: TextField(
                      controller: mediaController,
                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}'),
                        ),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Média',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: TextField(
                      controller: provaFinalController,
                      textInputAction: TextInputAction.done,
                      maxLines: 1,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}'),
                        ),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Prova Final',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: clearFields,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(60, 60),
                      padding: const EdgeInsets.all(0),
                    ),
                    child: const Icon(Icons.clear_all, size: 28),
                  ),
                  const SizedBox(width: 10),
                  ValueListenableBuilder<bool>(
                    valueListenable: isButtonEnabled,
                    builder: (context, value, child) {
                      return ElevatedButton(
                        onPressed: value ? verifyFinal : null,
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
      ),
    );
  }
}
