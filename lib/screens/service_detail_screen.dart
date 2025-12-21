import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

class ServiceDetailScreen extends StatefulWidget {
  final ServiceItem service;
  const ServiceDetailScreen({super.key, required this.service});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  int _carIndex = 0;
  DateTime _when = DateTime.now().add(const Duration(hours: 2));

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(title: Text(widget.service.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.timer),
              title:
                  Text('Approx Duration: ${widget.service.durationMins} mins'),
              subtitle: Text(widget.service.short),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(widget.service.details),
              ),
            ),
            const Divider(),
            Row(
              children: [
                const Text('Select Car: '),
                const SizedBox(width: 8),
                DropdownButton<int>(
                  value: _carIndex,
                  items: List.generate(app.cars.length, (i) {
                    final c = app.cars[i];
                    return DropdownMenuItem(
                        value: i,
                        child: Text('${c.make} ${c.model} (${c.regNumber})'));
                  }),
                  onChanged: (v) => setState(() => _carIndex = v ?? 0),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Date & Time: '),
                TextButton(
                  onPressed: () async {
                    final d = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                      initialDate: _when,
                    );
                    if (d == null) return;
                    final t = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(_when));
                    if (t == null) return;
                    setState(() => _when =
                        DateTime(d.year, d.month, d.day, t.hour, t.minute));
                  },
                  child: Text(_when.toString()),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  app.book(widget.service, app.cars[_carIndex], _when);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Booking placed')));
                  Navigator.pop(context);
                },
                child: Text(widget.service.price > 0
                    ? 'Book for ₹${widget.service.price}'
                    : 'Book Inspection'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
