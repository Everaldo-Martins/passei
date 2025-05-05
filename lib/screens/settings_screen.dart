import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:passei/themes/theme_manager.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Não foi possível abrir $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/images/icon.svg',
          height: 32,
          fit: BoxFit.contain,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeadingTitle('Configurações'),
              _buildSectionTitle('Temas'),
              const SizedBox(height: 8),
              _buildThemeSelector(context),
              const SizedBox(height: 24),

              _buildSectionTitle('Sobre o Aplicativo'),
              const Text(
                'O Passei! é um aplicativo desenvolvido em Flutter que ajuda estudantes a calcular médias aritméticas, ponderadas ou finais, indicando se o aluno está aprovado, precisa fazer final ou está reprovado.',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('Guia de Uso'),
              _buildFeatureItem(
                Icons.add,
                'Adiciona um novo campo (até 4 campos)',
              ),
              _buildFeatureItem(
                Icons.remove,
                'Remove o último campo adicionado',
              ),
              _buildFeatureItem(Icons.clear_all, 'Limpa todos os campos'),
              _buildFeatureItem(
                Icons.check,
                'Calcula a média (todos campos devem estar preenchidos)',
              ),
              const SizedBox(height: 16),
              _buildSectionTitle('Conecte-se Comigo'),
              const SizedBox(height: 16),
              _buildSocialButtons(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeadingTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: double.infinity, // Ocupa toda a largura disponível
        child: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: 16),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildSocialButton(BuildContext context, String url, String iconPath) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: IconButton(
        onPressed: () => openUrl(url),
        icon: Image.asset(iconPath, width: 24),
      ),
    );
  }

  Widget _buildSocialButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSocialButton(
          context,
          'https://www.linkedin.com/in/everaldo-martins-de-oliveira-214400b3',
          'assets/images/icons/linkedin.png',
        ),
        _buildSocialButton(
          context,
          'https://www.instagram.com/everaldo_martins1',
          'assets/images/icons/instagram.png',
        ),
        _buildSocialButton(
          context,
          'https://github.com/Everaldo-Martins',
          Theme.of(context).brightness == Brightness.light
              ? 'assets/images/icons/github-light.png'
              : 'assets/images/icons/github-dark.png',
        ),
        _buildSocialButton(
          context,
          'mailto:everaldoinfortecnico@gmail.com',
          'assets/images/icons/gmail.png',
        ),
      ],
    );
  }

  Widget _buildThemeSelector(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Row(
      children: [
        _buildThemeOption(
          context,
          ThemeMode.light,
          Icons.light_mode,
          'Claro',
          themeManager.themeMode == ThemeMode.light,
          () => themeManager.updateThemeMode(ThemeMode.light),
        ),
        const SizedBox(width: 12),
        _buildThemeOption(
          context,
          ThemeMode.dark,
          Icons.dark_mode,
          'Escuro',
          themeManager.themeMode == ThemeMode.dark,
          () => themeManager.updateThemeMode(ThemeMode.dark),
        ),
        const SizedBox(width: 12),
        _buildThemeOption(
          context,
          ThemeMode.system,
          Icons.settings_suggest,
          'Sistema',
          themeManager.themeMode == ThemeMode.system,
          () => themeManager.updateThemeMode(ThemeMode.system),
        ),
      ],
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    ThemeMode mode,
    IconData icon,
    String label,
    bool isSelected,
    VoidCallback onTap,
  ) {
    final theme = Theme.of(context);

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color:
                isSelected
                    ? theme.colorScheme.primaryContainer
                    : theme.colorScheme.surfaceContainerHighest,
            border:
                isSelected
                    ? Border.all(color: theme.colorScheme.primary, width: 2)
                    : null,
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? theme.colorScheme.primary : null),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? theme.colorScheme.primary : null,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ThemeNotifier with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}
