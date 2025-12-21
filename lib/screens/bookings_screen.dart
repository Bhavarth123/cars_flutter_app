import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final df = DateFormat('dd MMM, hh:mm a');

    return SafeArea(
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: app.bookings.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) {
          final b = app.bookings[i];

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ================= Top Section =================
                  Text(
                    b.service.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 6),

                  Text(
                    'Car: ${b.car.make} ${b.car.model}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Reg No: ${b.car.regNumber}',
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  Text(
                    'Booking Date: ${df.format(b.dateTime)}',
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),

                  const Divider(height: 20),

                  // ================= Bottom Section =================
                  Text(
                    "Select Car Model",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 6),

                  DropdownButton<String>(
                    value: ["Sedan", "SUV", "Hatchback"].contains(b.car.model)
                        ? b.car.model
                        : null, // <-- FIXED HERE
                    items: const [
                      DropdownMenuItem(value: "Sedan", child: Text("Sedan")),
                      DropdownMenuItem(value: "SUV", child: Text("SUV")),
                      DropdownMenuItem(
                          value: "Hatchback", child: Text("Hatchback")),
                    ],
                    onChanged: (_) {
                      // you can update model in state here
                    },
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Select Date & Time",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 6),
                  OutlinedButton.icon(
                    onPressed: () async {
                      // You can open DatePicker + TimePicker here
                    },
                    icon: const Icon(Icons.calendar_today),
                    label: const Text("Choose Date & Time"),
                  ),

                  const SizedBox(height: 16),

                  // ================= Status & Cancel =================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Status: ${b.status}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: b.status == 'booked'
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                        ),
                      ),
                      if (b.status == 'booked')
                        OutlinedButton(
                          onPressed: () =>
                              context.read<AppState>().cancel(b.id),
                          child: const Text("Cancel"),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
