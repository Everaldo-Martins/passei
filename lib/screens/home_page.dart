import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:passei/screens/settings_screen.dart';
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
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Settings(),
        fullscreenDialog: true, // Estilo modal para settings
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/icon.svg',
                  height: 32,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.settings, size: 28),
              onPressed: () => _navigateToSettings(context),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorWeight: 2,
          indicatorSize: TabBarIndicatorSize.tab,
          labelPadding: const EdgeInsets.symmetric(vertical: 8.0),
          tabs: const [
            Tab(icon: Icon(Icons.calculate_outlined), text: 'Aritmética'),
            Tab(icon: Icon(Icons.checklist_sharp), text: 'Ponderada'),
            Tab(icon: Icon(Icons.note_alt_outlined), text: 'Prova Final'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          ArithmeticAverageScreen(),
          WeightedAverageScreen(),
          CheckFinalScreen(),
        ],
      ),
    );
  }
}
