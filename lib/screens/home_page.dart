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
  late TabController _tabController;

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
        preferredSize: const Size.fromHeight(150),
        child: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset('assets/icon.svg', height: 32),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const About()),
                  );
                },
                icon: const Icon(Icons.help, size: 32),
              ),
            ],
          ),
          bottom: TabBar(
            controller: _tabController,
            indicatorWeight: 1,
            tabs: const [
              Tab(
                icon: Icon(Icons.calculate_outlined),
                child: Text('Aritmética'),
              ),
              Tab(icon: Icon(Icons.checklist_sharp), child: Text('Ponderada')),
              Tab(
                icon: Icon(Icons.note_alt_outlined),
                child: Text('Prova Final'),
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
