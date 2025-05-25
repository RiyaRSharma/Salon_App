import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/auth_service.dart';
import 'firebase_options.dart';
import 'screens/home_page.dart';
import 'screens/book_salons.dart';
import 'screens/my_bookings.dart';
import 'screens/saved_salons.dart';
import 'screens/booking_flow.dart'; //✅ Booking Flow
import 'screens/profile_page.dart'; // ✅ Profile Page
// import 'screens/review_page.dart'; // ✅ Review Page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Salon App',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: AuthService().handleAuthState(), // ✅ Check Auth state
      routes: {
        '/home': (context) => const HomePage(),
        '/bookSalon': (context) => BookSalonPage(),
        '/myBookings': (context) => MyBookingsPage(),
        '/savedSalons': (context) => SavedSalonsPage(),
        '/bookingFlow': (context) => const BookingFlowPage(), // 🆕 Booking Flow
        '/profile': (context) => ProfilePage(), // 🆕 Profile Page
        // '/reviews': (context) => const ReviewPage(), // 🆕 Review Page
      },
    );
  }
}
