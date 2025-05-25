import 'package:flutter/material.dart';
import 'payment.dart';

class BookingFlowPage extends StatefulWidget {
  final Map<String, dynamic>? bookingDetails;

  const BookingFlowPage({super.key, this.bookingDetails});

  @override
  BookingFlowPageState createState() => BookingFlowPageState();
}

class BookingFlowPageState extends State<BookingFlowPage> {
  String? selectedService;
  String? selectedStaff;
  String? selectedSlot;
  bool isSlotAvailable = true;

  final List<String> services = ['Haircut', 'Facial', 'Massage', 'Manicure'];
  final List<String> staff = ['John Doe', 'Jane Smith', 'Mike Lee'];
  final List<String> slots = ['10:00 AM', '12:00 PM', '2:00 PM', '4:00 PM'];

  @override
  void initState() {
    super.initState();
    if (widget.bookingDetails != null) {
      // ✅ Check that the values exist in the respective lists
      final s = widget.bookingDetails!['service'];
      final st = widget.bookingDetails!['staff'];
      final sl = widget.bookingDetails!['slot'];

      selectedService = services.contains(s) ? s : null;
      selectedStaff = staff.contains(st) ? st : null;
      selectedSlot = slots.contains(sl) ? sl : null;
    }
  }

  Future<bool> checkSlotAvailability(String slot) async {
    await Future.delayed(const Duration(seconds: 1));
    return slot != '2:00 PM';
  }

  void navigateToPayment() async {
    if (selectedService != null && selectedStaff != null && selectedSlot != null) {
      final BuildContext currentContext = context;

      bool slotAvailable = await checkSlotAvailability(selectedSlot!);
      if (!currentContext.mounted) return;

      if (slotAvailable) {
        if (currentContext.mounted) {
          Navigator.push(
            currentContext,
            MaterialPageRoute(
              builder: (context) => PaymentPage(
                bookingDetails: {
                  "service": selectedService!,
                  "staff": selectedStaff!,
                  "slot": selectedSlot!,
                },
              ),
            ),
          );
        }
      } else {
        if (currentContext.mounted) {
          ScaffoldMessenger.of(currentContext).showSnackBar(
            const SnackBar(content: Text('Slot is no longer available. Please choose another slot.')),
          );
          setState(() {
            isSlotAvailable = false;
          });
        }
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select all options!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Your Salon Appointment',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Service', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: services.contains(selectedService) ? selectedService : null,
              hint: const Text('Choose Service'),
              items: services.map((String service) {
                return DropdownMenuItem<String>(
                  value: service,
                  child: Text(service),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedService = value;
                });
              },
            ),
            const SizedBox(height: 16),

            const Text('Select Staff', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: staff.contains(selectedStaff) ? selectedStaff : null,
              hint: const Text('Choose Staff'),
              items: staff.map((String staff) {
                return DropdownMenuItem<String>(
                  value: staff,
                  child: Text(staff),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedStaff = value;
                });
              },
            ),
            const SizedBox(height: 16),

            const Text('Select Available Slot', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: slots.contains(selectedSlot) ? selectedSlot : null,
              hint: const Text('Choose Slot'),
              items: slots.map((String slot) {
                return DropdownMenuItem<String>(
                  value: slot,
                  child: Text(slot),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSlot = value;
                  isSlotAvailable = true;
                });
              },
            ),
            if (!isSlotAvailable)
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  '⚠️ Selected slot is not available. Please choose another slot.',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: navigateToPayment,
                child: const Text('Proceed to Payment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
