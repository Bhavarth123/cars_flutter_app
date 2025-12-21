import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

class MyCarsScreen extends StatelessWidget {
  const MyCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: app.cars.length,
              itemBuilder: (_, i) {
                final c = app.cars[i];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.directions_car),
                    title: Text('${c.make} ${c.model}'),
                    subtitle: Text(c.regNumber),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: FilledButton.icon(
              onPressed: () => showDialog(
                  context: context, builder: (_) => const _AddCarDialog()),
              icon: const Icon(Icons.add),
              label: const Text('Add Car'),
            ),
          )
        ],
      ),
    );
  }
}

class _AddCarDialog extends StatefulWidget {
  const _AddCarDialog();

  @override
  State<_AddCarDialog> createState() => _AddCarDialogState();
}

class _AddCarDialogState extends State<_AddCarDialog> {
  final _make = TextEditingController();
  final _model = TextEditingController();
  final _reg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Car'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
              controller: _make,
              decoration: const InputDecoration(labelText: 'Make')),
          TextField(
              controller: _model,
              decoration: const InputDecoration(labelText: 'Model')),
          TextField(
              controller: _reg,
              decoration:
                  const InputDecoration(labelText: 'Registration Number')),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close')),
        FilledButton(
          onPressed: () {
            context.read<AppState>().addCar(_make.text, _model.text, _reg.text);
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
