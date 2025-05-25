import 'package:flutter/material.dart';
import 'book_salons.dart';
import 'my_bookings.dart';
import 'saved_salons.dart';
import 'profile_page.dart'; // ✅ Profile Page

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Salon Booking',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, size: 28), // ✅ Profile Icon
            onPressed: () {
              navigateToPage(context, ProfilePage());
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFDFE9F3), Color(0xFFE4D7F5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            _buildCard(
              context,
              'Search & Book Salons',
              'Find the best salons near you and book hassle-free.',
              Icons.search,
                  () => navigateToPage(context, BookSalonPage()), // ✅ Corrected Navigation
            ),
            _buildCard(
              context,
              'My Bookings',
              'View your past and upcoming salon appointments.',
              Icons.event_note,
                  () => navigateToPage(context, MyBookingsPage()), // ✅ Corrected Navigation
            ),
            _buildCard(
              context,
              'Saved Salons',
              'Your favorite salons for quick and easy booking.',
              Icons.favorite,
                  () => navigateToPage(context, SavedSalonsPage()), // ✅ Corrected Navigation
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String description,
      IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          leading: Icon(icon, size: 32, color: Colors.blue),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          subtitle: Text(description),
          trailing: const Icon(Icons.arrow_forward_ios, size: 20),
        ),
      ),
    );
  }
}
