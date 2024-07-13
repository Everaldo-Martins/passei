import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'about_page.dart';
import 'arithmetic_average_screen.dart';
import 'weighted_average_screen.dart';
import 'check_final_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: AppBar(
          backgroundColor: WidgetStateColor.transparent,
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
                      color: const Color(0xFFFF3B3F),
                      icon: const Icon(
                        Icons.help,
                        size: 32,
                      ),
                    ),
                  ],
                ),
                bottom: TabBar(
                  controller: _tabController,
                  indicatorColor: const Color(0xFFFF3B3F),
                  unselectedLabelColor: const Color(0xFFFF3B3F),
                  labelColor: const Color(0xFFFF3B3F),
                  overlayColor: const WidgetStatePropertyAll(Color(0x22FF3B3F)),
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
                        'Prova Final',
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
        child: TabBarView(
          controller: _tabController,
          children: const [
            ArithmeticAverageScreen(),
            WeightedAverageScreen(),
            CheckFinalScreen(),
          ],
        ),
      ),
    );
  }
}
