import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class ServiceItem {
  final String id, title, short, details, icon;
  final int price, durationMins;
  ServiceItem({
    required this.id,
    required this.title,
    required this.icon,
    required this.price,
    required this.durationMins,
    required this.short,
    required this.details,
  });

  factory ServiceItem.fromJson(Map<String, dynamic> j) => ServiceItem(
        id: j['id'],
        title: j['title'],
        icon: j['icon'],
        price: j['price'],
        durationMins: j['duration_mins'],
        short: j['short'],
        details: j['details'],
      );
}

class Car {
  final String id;
  final String make;
  final String model;
  final String regNumber;
  Car(
      {required this.id,
      required this.make,
      required this.model,
      required this.regNumber});
}

class Booking {
  final String id;
  final ServiceItem service;
  final Car car;
  final DateTime dateTime;
  final String status; // booked, in_progress, done, cancelled
  Booking(
      {required this.id,
      required this.service,
      required this.car,
      required this.dateTime,
      required this.status});
}

class AppState extends ChangeNotifier {
  List<ServiceItem> services = [];
  List<Car> cars = [];
  List<Booking> bookings = [];

  Future<void> load() async {
    // load services from local json for instant run
    final jsonStr = await rootBundle.loadString('assets/data/services.json');
    final list = (json.decode(jsonStr) as List)
        .map((e) => ServiceItem.fromJson(e))
        .toList();
    services = list;

    // some demo cars
    cars = [
      Car(
          id: _uuid.v4(),
          make: 'Maruti',
          model: 'Swift',
          regNumber: 'GJ 01 AB 1234'),
      Car(
          id: _uuid.v4(),
          make: 'Hyundai',
          model: 'i20',
          regNumber: 'GJ 05 XY 9876'),
    ];

    notifyListeners();
  }

  void addCar(String make, String model, String reg) {
    cars.add(Car(id: _uuid.v4(), make: make, model: model, regNumber: reg));
    notifyListeners();
  }

  void book(ServiceItem s, Car c, DateTime dt) {
    bookings.add(Booking(
        id: _uuid.v4(), service: s, car: c, dateTime: dt, status: 'booked'));
    notifyListeners();
  }

  void cancel(String bookingId) {
    final idx = bookings.indexWhere((b) => b.id == bookingId);
    if (idx != -1) {
      bookings[idx] = Booking(
        id: bookings[idx].id,
        service: bookings[idx].service,
        car: bookings[idx].car,
        dateTime: bookings[idx].dateTime,
        status: 'cancelled',
      );
      notifyListeners();
    }
  }
}
