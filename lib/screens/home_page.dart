import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'about.dart';
import 'media_aritmetica_screen.dart';
import 'media_ponderada_screen.dart';
import 'verificar_final_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required String title});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF3B3F),
        foregroundColor: const Color(0xFF798897),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              'assets/icon.svg',
              height: 32,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const About(),
                  ),
                );
              },
              icon: const Icon(
                Icons.help,
                size: 32,
              ),
              color: const Color(0xFFFFF6F4),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFFFF6F4),
          unselectedLabelColor: const Color(0xAAFFF6F4),
          labelColor: const Color(0xFFFFF6F4),
          indicatorWeight: 1,
          tabs: const [
            Tab(
              icon: Icon(
                Icons.calculate,
                size: 32,
              ),
              child: Text(
                'Aritmética',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.calculate,
                size: 32,
              ),
              child: Text(
                'Ponderada',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.event_note,
                size: 32,
              ),
              child: Text(
                'Final',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          MediaAritmeticaScreen(),
          MediaPonderadaScreen(),
          VerificarFinalScreen(),
        ],
      ),
    );
  }
}
