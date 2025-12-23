import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'state/app_state.dart';
import 'screens/home_screen.dart';
import 'screens/services_screen.dart';
import 'screens/bookings_screen.dart';
import 'screens/my_cars_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

class GarageLocationScreen extends StatelessWidget {
  const GarageLocationScreen({super.key});

  final LatLng garageLocation = const LatLng(22.2686216, 70.8006619);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Garage Location")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: garageLocation,
          zoom: 16,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('garage'),
            position: garageLocation,
            infoWindow: const InfoWindow(title: "Jay Chamunda Motors"),
          ),
        },
      ),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize Firebase Messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request notification permissions (iOS)
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  // Get FCM token
  String? token = await messaging.getToken();
  print("FCM Token: $token");

  // Foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Push notification received: ${message.notification?.title}");
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _theme() {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E88E5)),
      textTheme: GoogleFonts.interTextTheme(base.textTheme),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState()..load(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GoMechanic',
        theme: _theme(),
        home: const RootScreen(),
      ),
    );
  }
}

/// =====================
/// ROOT SCREEN
/// =====================
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;

    if (_user == null) {
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return const SizedBox.shrink();
    }
    return const _Root();
  }
}

/// =====================
/// ROOT NAVIGATION
/// =====================
class _Root extends StatefulWidget {
  const _Root({super.key});

  @override
  State<_Root> createState() => _RootState();
}

class _RootState extends State<_Root> {
  int _index = 0;

  final _screens = const [
    HomeScreen(),
    ServicesScreen(),
    BookingsScreen(),
    MyCarsScreen(),
    ProfileScreen(),
    GarageLocationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.build_outlined),
            selectedIcon: Icon(Icons.build),
            label: 'Services',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Bookings',
          ),
          NavigationDestination(
            icon: Icon(Icons.directions_car_outlined),
            selectedIcon: Icon(Icons.directions_car),
            label: 'My Cars',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.location_on_outlined),
            selectedIcon: Icon(Icons.location_on),
            label: 'Garage',
          ),
        ],
      ),
    );
  }
}
