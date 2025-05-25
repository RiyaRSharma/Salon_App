import 'package:flutter/material.dart';

class MyBookingsPage extends StatelessWidget {
  final List<Map<String, String>> bookings = [
    {"salon": "Luxury Salon", "slot": "3:00 PM", "staff": "John"},
    {"salon": "Elite Spa & Salon", "slot": "5:00 PM", "staff": "Lisa"},
  ];

  MyBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Bookings")),
      body: bookings.isEmpty
          ? const Center(child: Text("No bookings yet."))
          : ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return Card(
            child: ListTile(
              title: Text("${booking["salon"]} - ${booking["slot"]}"),
              subtitle: Text("Staff: ${booking["staff"]}"),
              trailing: ElevatedButton(
                onPressed: () {
                  // Cancel Booking Logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Cancelled booking at ${booking["salon"]}")),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Cancel", style: TextStyle(color: Colors.white)),
              ),
            ),
          );
        },
      ),
    );
  }
}
