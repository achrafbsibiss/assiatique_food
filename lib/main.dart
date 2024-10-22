import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'screens/home_screen.dart';
import 'screens/recipe_list_screen.dart';
import 'screens/recipe_grid_screen.dart';
import 'screens/contact_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFE64A19),
        hintColor: Color(0xFFFFA726),
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          headlineSmall: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
          headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
          bodyMedium: TextStyle(fontSize: 16, color: Color(0xFF424242)),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    RecipeListScreen(),
    RecipeGridScreen(),
    ContactScreen(),
  ];

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, 50 * (1 - _animation.value)),
            child: Opacity(
              opacity: _animation.value,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  child: BottomNavigationBar(
                    items: <BottomNavigationBarItem>[
                      _buildNavItem('assets/icons/home.svg', 'Home'),
                      _buildNavItem('assets/icons/recipe.svg', 'Recipes'),
                      _buildNavItem('assets/icons/gallery.svg', 'Gallery'),
                      _buildNavItem('assets/icons/contact.svg', 'Contact'),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: Theme.of(context).primaryColor,
                    unselectedItemColor: Colors.grey[600],
                    backgroundColor: Colors.transparent,
                    type: BottomNavigationBarType.fixed,
                    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                    onTap: _onItemTapped,
                    elevation: 0,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String iconPath, String label) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        iconPath,
        width: 24,
        height: 24,
        color: Colors.grey[600],
      ),
      activeIcon: SvgPicture.asset(
        iconPath,
        width: 24,
        height: 24,
        color: Theme.of(context).primaryColor,
      ),
      label: label,
    );
  }
}