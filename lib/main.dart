import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/splash_screen.dart';
import 'Screens/splash_screen2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

Future<bool> _checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

@override
Widget build(BuildContext context) {

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: FutureBuilder<bool>(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the future to complete, show a loading indicator
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // If there's an error, display an error message
          return const Center(child: Text('Error checking login status'));
        } else {
          // If the future completes, navigate to the appropriate screen
          bool isLoggedIn = snapshot.data ?? false;
          if (isLoggedIn) {
            return SplashScreen2();
          } else {
            return SplashScreen();
          }
        }
      },
    ),
  );
}
}




























// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'Screens/splash_screen.dart';
// import 'Screens/splash_screen2.dart';
// // import 'Screens/home_screen.dart'; // Import your home screen
// // import 'Screens/explore_screen.dart'; // Import your explore screen
// // import 'Screens/profile_screen.dart'; // Import your profile screen
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // Function to check login status
//   Future<bool> _checkLoginStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool('isLoggedIn') ?? false;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: FutureBuilder<bool>(
//         future: _checkLoginStatus(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             // Show loading indicator while waiting for the future to complete
//             return const Scaffold(
//               body: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           } else if (snapshot.hasError) {
//             // Display an error message if there's an error
//             return const Scaffold(
//               body: Center(
//                 child: Text('Error checking login status'),
//               ),
//             );
//           } else {
//             // Navigate to the appropriate screen based on login status
//             bool isLoggedIn = snapshot.data ?? false;
//             return isLoggedIn ? MainScreen() : SplashScreen();
//           }
//         },
//       ),
//     );
//   }
// }
//
// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;
//
//   static const List<Widget> _widgetOptions = <Widget>[
//     // HomeScreen(), // Your custom home screen widget
//     // ExploreScreen(), // Your custom explore screen widget
//     // ProfileScreen(), // Your custom profile screen widget
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _widgetOptions.elementAt(_selectedIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.explore),
//             label: 'Explore',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.orange, // Customize the selected item color
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

