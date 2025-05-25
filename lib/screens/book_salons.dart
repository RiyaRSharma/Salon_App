import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'booking_flow.dart';

class BookSalonPage extends StatefulWidget {
  const BookSalonPage({super.key});

  @override
  State<BookSalonPage> createState() => _BookSalonPageState();
}

class _BookSalonPageState extends State<BookSalonPage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> allSalons = [];
  List<dynamic> filteredSalons = [];

  @override
  void initState() {
    super.initState();
    fetchSalons();
    _searchController.addListener(_filterSalons);
  }

  void fetchSalons() async {
    try {
      final response = await Dio().get("http://localhost:5000/api/salons");
      setState(() {
        allSalons = response.data;
        filteredSalons = allSalons;
      });
    } catch (e) {
      print("Error fetching salons: $e");
    }
  }

  void _filterSalons() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredSalons = allSalons.where((salon) {
        return salon['name'].toLowerCase().contains(query) ||
            salon['address'].toLowerCase().contains(query) ||
            salon['rating'].toString().contains(query) ||
            (salon['services']?.toLowerCase() ?? '').contains(query) ||
            (salon['offer']?.toLowerCase() ?? '').contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search & Book Salons")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by name, address, rating...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: filteredSalons.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: filteredSalons.length,
                itemBuilder: (context, index) {
                  final salon = filteredSalons[index];
                  return SalonCard(
                    name: salon['name'],
                    location: salon['address'] ?? '',
                    rating: salon['rating'].toString(),
                    services: salon['services'] ?? 'Not mentioned',
                    offer: salon['offer'] ?? '',
                    price: salon['price']?.toString() ?? '0',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SalonCard extends StatelessWidget {
  final String name;
  final String location;
  final String rating;
  final String services;
  final String offer;
  final String price;

  const SalonCard({
    required this.name,
    required this.location,
    required this.rating,
    required this.services,
    required this.offer,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(location, style: const TextStyle(color: Colors.grey)),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow),
                Text(" $rating Rating", style: const TextStyle(color: Colors.green)),
              ],
            ),
            Text(services, style: const TextStyle(color: Colors.blue)),
            Text(offer, style: const TextStyle(color: Colors.red)),
            Text('Price: ₹$price', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingFlowPage(
                      bookingDetails: {
                        "salon": name,
                        "service": services,
                        "staff": "To be selected",
                        "slot": "To be selected",
                        "amount": price,
                      },
                    ),
                  ),
                );
              },
              child: const Text("Book Now"),
            ),
          ],
        ),
      ),
    );
  }
}
