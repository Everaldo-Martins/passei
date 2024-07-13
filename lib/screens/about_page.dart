import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({super.key});

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Não foi possível abrir $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          foregroundColor: const Color(0xFFFF3B3F),
          flexibleSpace: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/bg_appbar.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              AppBar(
                backgroundColor: const Color(0x99FFF6F4),
                titleSpacing: 1,
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'assets/icon.svg',
                      height: 32,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
            opacity: 0.4,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Olá, este é o aplicativo Passei! Desenvolvido inteiramente com Flutter, ele ajuda estudantes a calcular rapidamente suas médias aritméticas, ponderadas ou finais. Com base nas informações fornecidas, o aplicativo informa se o aluno está aprovado, precisa fazer a final ou está reprovado.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF798897),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: Color(0x22798897)),
                    const SizedBox(height: 16),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Guia de uso',
                          style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF798897),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/add.png',
                          height: 70,
                        ),
                        const SizedBox(width: 16),
                        const Flexible(
                          child: Text(
                            'Adiciona um novo campo. Será exibido enquanto houver menos de quatro campos.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF798897),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/remove.png',
                          height: 70,
                        ),
                        const SizedBox(width: 16),
                        const Flexible(
                          child: Text(
                            'Remove o último campo adicionado. Será exibido somente quando houver mais de dois campos.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF798897),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/clear.png',
                          height: 70,
                        ),
                        const SizedBox(width: 16),
                        const Flexible(
                          child: Text(
                            'Limpa o conteúdo dos campos. Só funcionará se houver informações no formulário.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF798897),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/send.png',
                          height: 70,
                        ),
                        const SizedBox(width: 16),
                        const Flexible(
                          child: Text(
                            'Envia o formulário para verificar a média. Só funcionará se todos os campos estiverem preenchidos.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF798897),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Conecte-se comigo nas redes sociais',
                  style: TextStyle(
                    color: Color(0xFF798897),
                    fontFamily: 'Ubuntu',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  child: IconButton(
                    onPressed: () => openUrl(
                        'https://www.linkedin.com/in/everaldo-martins-de-oliveira-214400b3'),
                    icon: Image.asset(
                      'assets/icons/linkedin.png',
                      width: 25,
                    ),
                  ),
                ),
                Card(
                  child: IconButton(
                    onPressed: () =>
                        openUrl('https://www.instagram.com/everaldo_martins1'),
                    icon: Image.asset(
                      'assets/icons/instagram.png',
                      width: 25,
                    ),
                  ),
                ),
                Card(
                  child: IconButton(
                    onPressed: () =>
                        openUrl('https://github.com/Everaldo-Martins'),
                    icon: Image.asset(
                      'assets/icons/github.png',
                      width: 25,
                    ),
                  ),
                ),
                Card(
                  child: IconButton(
                    onPressed: () =>
                        openUrl('mailto:everaldoinfortecnico@gmail.com'),
                    icon: Image.asset(
                      'assets/icons/gmail.png',
                      width: 25,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
