import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        foregroundColor: const Color(0xFFF9F9F9),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icon.svg',
              height: 32,
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xF9F9F9FF),
          unselectedLabelColor: const Color(0x99F9F9F9),
          labelColor: const Color(0xFFF9F9F9),
          indicatorWeight: 1,
          tabs: const [
            Tab(
              icon: Icon(
                Icons.calculate_rounded,
                size: 28,
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
                Icons.calculate_rounded,
                size: 28,
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
                Icons.event_note_rounded,
                size: 28,
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
