import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({
    super.key,
  });

  void linkedin() {}

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
                const Text(
                  'Instruções de uso',
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF798897),
                  ),
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
                          fontSize: 13,
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
                          fontSize: 13,
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
                          fontSize: 13,
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
                          fontSize: 13,
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
                    IconButton(
                      onPressed: linkedin,
                      icon: const Icon(
                        Icons.add_comment_sharp,
                        size: 36,
                        color: Color(0xFFFF3B3F),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    IconButton(
                      onPressed: linkedin,
                      icon: const Icon(
                        Icons.add_comment_sharp,
                        size: 36,
                        color: Color(0xFFFF3B3F),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    IconButton(
                      onPressed: linkedin,
                      icon: const Icon(
                        Icons.add_comment_sharp,
                        size: 36,
                        color: Color(0xFFFF3B3F),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    IconButton(
                      onPressed: linkedin,
                      icon: const Icon(
                        Icons.add_comment_sharp,
                        size: 36,
                        color: Color(0xFFFF3B3F),
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
