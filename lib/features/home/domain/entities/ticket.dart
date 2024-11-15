import 'package:flutter_vision/features/home/domain/entities/item.dart';
import 'package:flutter_vision/features/home/domain/entities/machine.dart';

class Ticket {
  final String website;
  final String company;
  final int ticketNumber;
  final String barcode;
  final List<Item> items;
  final String returnPolicy;
  final Machine machine;
  final String timestamp;

  Ticket({
    required this.website,
    required this.company,
    required this.ticketNumber,
    required this.barcode,
    required this.items,
    required this.returnPolicy,
    required this.machine,
    required this.timestamp,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      website: json['website'],
      company: json['company'],
      ticketNumber: json['ticket_number'],
      barcode: json['barcode'],
      items:
          (json['items'] as List).map((item) => Item.fromJson(item)).toList(),
      returnPolicy: json['return_policy'],
      machine: Machine.fromJson(json['machine']),
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'website': website,
      'company': company,
      'ticket_number': ticketNumber,
      'barcode': barcode,
      'items': items.map((item) => item.toJson()).toList(),
      'return_policy': returnPolicy,
      'machine': machine.toJson(),
      'timestamp': timestamp,
    };
  }
}
