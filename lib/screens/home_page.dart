import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passei/screens/about_page.dart';
import 'package:passei/screens/arithmetic_average_screen.dart';
import 'package:passei/screens/check_final_screen.dart';
import 'package:passei/screens/weighted_average_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
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
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: SvgPicture.asset('assets/icon.svg', height: 32)),
              IconButton(
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const About()),
                    ),
                icon: const Icon(Icons.help, size: 32),
              ),
            ],
          ),
          bottom: TabBar(
            controller: _tabController,
            indicatorWeight: 1,
            labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            tabs: const [
              Tab(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calculate_outlined),
                    Text('Aritmética'),
                  ],
                ),
              ),
              Tab(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.checklist_sharp), Text('Ponderada')],
                ),
              ),
              Tab(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.note_alt_outlined),
                    Text('Prova Final'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ArithmeticAverageScreen(),
          WeightedAverageScreen(),
          CheckFinalScreen(),
        ],
      ),
    );
  }
}
