import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passei/themes/app_themes.dart';

class CheckFinalScreen extends StatefulWidget {
  const CheckFinalScreen({super.key});

  @override
  CheckFinalScreenState createState() => CheckFinalScreenState();
}

class CheckFinalScreenState extends State<CheckFinalScreen> {
  final TextEditingController mediaController = TextEditingController();
  final TextEditingController provaFinalController = TextEditingController();
  final ValueNotifier<bool> hasContent = ValueNotifier<bool>(false);
  final ValueNotifier<bool> allFieldsValid = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    mediaController.addListener(_updateButtonStates);
    provaFinalController.addListener(_updateButtonStates);
  }

  @override
  void dispose() {
    mediaController.removeListener(_updateButtonStates);
    provaFinalController.removeListener(_updateButtonStates);
    mediaController.dispose();
    provaFinalController.dispose();
    hasContent.dispose();
    allFieldsValid.dispose();
    super.dispose();
  }

  void _updateButtonStates() {
    final hasText =
        mediaController.text.isNotEmpty || provaFinalController.text.isNotEmpty;
    final allValid =
        mediaController.text.isNotEmpty && provaFinalController.text.isNotEmpty;

    hasContent.value = hasText;
    allFieldsValid.value = allValid;
  }

  void verifyFinal() {
    final media = _parseDouble(mediaController.text);
    final provaFinal = _parseDouble(provaFinalController.text);

    if (!_validateInputs(media, provaFinal)) return;

    final finalMedia = ((media * 6) + (provaFinal * 4)) / 10;
    _showResultDialog(finalMedia);
  }

  double _parseDouble(String value) {
    return double.tryParse(value.replaceAll(',', '.')) ?? 0;
  }

  bool _validateInputs(double media, double provaFinal) {
    if (media < 0 || media > 10 || provaFinal < 0 || provaFinal > 10) {
      _showErrorDialog('As notas devem estar entre 0 e 10.');
      return false;
    }
    return true;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Erro'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showResultDialog(double finalMedia) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.all(16),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Text(
                  finalMedia >= 5.0 ? 'Aprovado' : 'Reprovado',
                  style: TextStyle(
                    color:
                        finalMedia >= 5.0
                            ? AppThemes.approved
                            : AppThemes.failed,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text('com média'),
                const SizedBox(height: 16),
                Text(
                  finalMedia.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
    );
  }

  void clearFields() {
    mediaController.clear();
    provaFinalController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox.expand(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'Insira a média e a nota da prova final',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildNumberField(
                      controller: mediaController,
                      label: 'Média',
                      context: context,
                    ),
                    const SizedBox(height: 16),
                    _buildNumberField(
                      controller: provaFinalController,
                      label: 'Prova Final',
                      context: context,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildActionButtons(context, theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberField({
    required TextEditingController controller,
    required String label,
    required BuildContext context,
  }) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.next,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon:
              controller.text.isNotEmpty
                  ? IconButton(
                    icon: const Icon(Icons.clear, size: 20),
                    onPressed: () {
                      controller.clear();
                      FocusScope.of(context).unfocus();
                    },
                  )
                  : null,
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: hasContent,
          builder: (_, hasContentValue, __) {
            return ElevatedButton(
              onPressed: hasContentValue ? clearFields : null,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(60, 60),
                padding: EdgeInsets.zero,
                backgroundColor:
                    hasContentValue
                        ? theme.colorScheme.primary
                        : theme.colorScheme.surfaceContainerHighest,
                foregroundColor:
                    hasContentValue
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onSurface.withValues(alpha: 0.38),
              ),
              child: const Icon(Icons.clear_all, size: 28),
            );
          },
        ),
        const SizedBox(width: 16),
        ValueListenableBuilder<bool>(
          valueListenable: allFieldsValid,
          builder: (_, allValid, __) {
            return ElevatedButton(
              onPressed: allValid ? verifyFinal : null,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(60, 60),
                padding: EdgeInsets.zero,
                backgroundColor:
                    allValid
                        ? theme.colorScheme.primary
                        : theme.colorScheme.surfaceContainerHighest,
                foregroundColor:
                    allValid
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onSurface.withValues(alpha: 0.38),
              ),
              child: const Icon(Icons.check, size: 28),
            );
          },
        ),
      ],
    );
  }
}
