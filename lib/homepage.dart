import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rive/rive.dart' as Rive;
import 'plantspage.dart';
import 'package:myapp/Searchpage.dart';
import 'package:flutter/services.dart';
import 'drawer.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
class homescreen extends StatelessWidget {
  const homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 900,
            child: Rive.RiveAnimation.asset(
              "assets/homepage.riv",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
    ;
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 1;
  final List<Widget> _pages = [PlantsPage(), homescreen(), SearchPage()];
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      drawer: mydrawer(context),
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.blueGrey.withOpacity(0.2)],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      // openScale: 1.0,
      disabledGestures: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
            leading: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () {
                  _advancedDrawerController.showDrawer();
                },
                icon: ValueListenableBuilder<AdvancedDrawerValue>(
                  valueListenable: _advancedDrawerController,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 250),
                      child: Semantics(
                        label: 'Menu',
                        onTapHint: 'expand drawer',
                        child: Icon(
                          value.visible ? Icons.clear : Icons.menu,
                          key: ValueKey<bool>(value.visible),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.greenAccent),
                accountName: Text(
                  "email",
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
                accountEmail: Text(
                  "password",
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
                currentAccountPicture: const Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 60,
                ),
              ),
              ListTile(
                title: const Text(
                  "Profile",
                  style: TextStyle(color: Colors.black),
                ),
                leading: const Icon(Icons.person, color: Colors.black),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Close', style: TextStyle(color: Colors.black)),
                leading: const Icon(Icons.close, color: Colors.black),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  'Log out',
                  style: TextStyle(color: Colors.black),
                ),
                leading: const Icon(Icons.logout_outlined, color: Colors.black),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  "Rover Model And Details",
                  style: TextStyle(color: Colors.black),
                ),
                leading: const Icon(
                  Icons.drive_eta_outlined,
                  color: Colors.black,
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text("About", style: TextStyle(color: Colors.black)),
                leading: const Icon(Icons.home, color: Colors.black),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  "Settings",
                  style: TextStyle(color: Colors.black),
                ),
                leading: const Icon(Icons.settings, color: Colors.black),
                onTap: () {},
              ),
            ],
          ),
        ),
        extendBodyBehindAppBar: true,
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: GNav(
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                rippleColor: Colors.blueGrey,
                hoverColor: Colors.blueGrey,
                haptic: true,
                tabBorderRadius: 30,
                tabActiveBorder: Border.all(color: Colors.transparent),
                tabBorder: Border.all(color: Colors.grey.shade300, width: 1),
                tabShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 600),
                gap: 10,
                color: Colors.grey[600],
                activeColor: Colors.white,
                iconSize: 20,
                tabBackgroundColor: Color(0xFF42A5F5),
      
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                tabs: [
                  GButton(icon: FontAwesomeIcons.plantWilt, text: 'Plants'),
                  GButton(icon: FontAwesomeIcons.house, text: 'Home'),
                  GButton(icon: FontAwesomeIcons.searchengin, text: 'Search'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
