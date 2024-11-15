class Machine {
  final String model;
  final String serialNumber;

  Machine({required this.model, required this.serialNumber});

  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      model: json['model'],
      serialNumber: json['serial_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'serial_number': serialNumber,
    };
  }
}
