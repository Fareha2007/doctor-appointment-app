// appointment_model.dart

class Appointment {
  final String doctorName;
  final String date;
  final String time;

  Appointment({
    required this.doctorName,
    required this.date,
    required this.time,
  });

  // Factory constructor to create an Appointment from a map
  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      doctorName: map['doctorName'] ?? 'Unknown Doctor',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
    );
  }
}
