import 'package:flutter/material.dart';
import '../state/app_state.dart';

class ServiceCard extends StatelessWidget {
  final ServiceItem service;
  final VoidCallback onTap;
  const ServiceCard({super.key, required this.service, required this.onTap});

  IconData _iconFromName(String name) {
    switch (name) {
      case 'build':
        return Icons.build;
      case 'ac_unit':
        return Icons.ac_unit;
      case 'tire_repair':
        return Icons.tire_repair;
      case 'battery_charging_full':
        return Icons.battery_charging_full;
      case 'cleaning_services':
        return Icons.cleaning_services;
      case 'miscellaneous_services':
        return Icons.miscellaneous_services;
      default:
        return Icons.handyman;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 1,
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(_iconFromName(service.icon), size: 36),
              const SizedBox(height: 8),

              // ✅ Title
              Text(
                service.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 6),

              // ✅ Flexible description
              Expanded(
                child: Text(
                  service.short,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),

              // ✅ Price at bottom
              if (service.price > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    "₹${service.price}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
