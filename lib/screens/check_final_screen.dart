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

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
                        Text(finalMedia >= 5.0 ? 'Aprovado' : 'Reprovado'),
                        SizedBox(height: 16),
                        Text('com média'),
                        SizedBox(height: 16),
                        Text(
                          finalMedia.toStringAsFixed(2),
                          style: TextStyle(
                            color:
                                finalMedia >= 5.0
                                    ? Color(0xFF00FF55)
                                    : Color(0xFFFF0000),
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
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: provaFinalController,
                  textInputAction: TextInputAction.done,
                  maxLines: 1,
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
                child: Icon(Icons.clear_all, size: 28),
              ),
              SizedBox(width: 10),
              ValueListenableBuilder<bool>(
                valueListenable: isButtonEnabled,
                builder: (context, value, child) {
                  return ElevatedButton(
                    onPressed: value ? verifyFinal : null,
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
