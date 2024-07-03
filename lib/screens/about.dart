import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({
    super.key,
  });

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Passei',
          style: TextStyle(
            color: Color(0xFFFFF6F4),
            fontFamily: 'Ubuntu',
            fontSize: 26,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color(0xFFFF3B3F),
        iconTheme: const IconThemeData(color: Color(0xFFFFF6F4)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sobre esse aplicativo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF798897),
                          fontFamily: 'Ubuntu',
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                const Row(
                  children: [                    
                    Flexible(
                      child: Text(
                        'Bem-vindo ao aplicativo Passei! Esta aplicação, desenvolvida em Flutter, foi projetada para ajudar estudantes a calcular rapidamente suas médias, seja aritmética, ponderada ou final. O aplicativo também informa se o aluno foi aprovado ou reprovado com base em suas notas.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 14,
                          color: Color(0xFF798897),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Guia de Uso',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF798897),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/add.png',
                      height: 60,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    const Flexible(
                      child: Text(
                        'Adiciona um novo campo. Será exibido até que o número de campos seja menor que quatro.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 14,
                          color: Color(0xFF798897),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/remove.png',
                      height: 60,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    const Flexible(
                      child: Text(
                        'Remove o último campo adicionado. Será exibido somente quando o número de campos for maior que dois.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 14,
                          color: Color(0xFF798897),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/clear.png',
                      height: 60,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    const Flexible(
                      child: Text(
                        'Limpa o conteúdo dos campos. Só funcionará se houver informações no formulário.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 14,
                          color: Color(0xFF798897),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/send.png',
                      height: 60,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    const Flexible(
                      child: Text(
                        'Envia o conteúdo do formulário para verificação da média. Só funcionará se todos os campos tiverem informações.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 14,
                          color: Color(0xFF798897),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 26),                
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Conecte-se comigo nas redes sociais',
                      style: TextStyle(
                          color: Color(0xFF798897),
                          fontFamily: 'Ubuntu',
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => openUrl(
                          'https://www.linkedin.com/in/everaldo-martins-de-oliveira-214400b3'),
                      icon: Image.asset(
                        'assets/icons/linkedin.png',
                        width: 40,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    IconButton(
                      onPressed: () => openUrl(
                          'https://www.instagram.com/everaldo_martins1'),
                      icon: Image.asset(
                        'assets/icons/instagram.png',
                        width: 40,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    IconButton(
                      onPressed: () =>
                          openUrl('https://github.com/Everaldo-Martins'),
                      icon: Image.asset(
                        'assets/icons/github.png',
                        width: 40,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    IconButton(
                      onPressed: () =>
                          openUrl('mailto:everaldoinfortecnico@gmail.com'),
                      icon: Image.asset(
                        'assets/icons/gmail.png',
                        width: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
