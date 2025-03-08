
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:predictivehealthcare/api/createappointmentapi.dart';
import 'package:predictivehealthcare/api/loginapi.dart';

class CreateAppointmentScreen extends StatefulWidget {
  final DateTime selectedDate;
  final doctorid;
  const CreateAppointmentScreen( {
    super.key,
    required this.selectedDate,
    required this.doctorid,
  });

  @override
  _CreateAppointmentScreenState createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _addressController = TextEditingController();
  final _reasonController = TextEditingController();

  late String formattedDate;

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd').format(widget.selectedDate);
  }

  void _submitAppointment() async {
    if (_nameController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _heightController.text.isEmpty ||
        _weightController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Please fill all fields and select date & time')),
      );
      return;
    }

    // Assuming lid is already defined elsewhere, or you'll need to replace it
    Map<String, dynamic> appointmentData = {
      'patient_name': _nameController.text,
      'patient_age': _ageController.text,
      'patient_height': _heightController.text,
      'patient_weight': _weightController.text,
      'patient_addr': _addressController.text,
      'APPOINTMENTDATE': formattedDate,
      // 'APPOINTMENTTIME': _selectedTime.toString(), // Uncomment and implement if needed
      'visitReason': _reasonController.text,
      "DOCTORID": widget.doctorid.toString(),
      "USERID": lid.toString() // Make sure lid is available or passed to the screen
    };

    await createAppointment(appointmentData, context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Appointment successfully created')),
    );
    Navigator.pop(context);
    // You can navigate to another screen if needed
    // Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorDetailsScreen(doctor: {})));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Appointment'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(_nameController, 'Name', Icons.person),
            const SizedBox(height: 12),
            _buildTextField(_ageController, 'Age', Icons.cake, isNumber: true),
            const SizedBox(height: 12),
            _buildTextField(_heightController, 'Height (cm)', Icons.height, isNumber: true),
            const SizedBox(height: 12),
            _buildTextField(_weightController, 'Weight (kg)', Icons.fitness_center, isNumber: true),
            const SizedBox(height: 12),
            _buildTextField(_addressController, 'Address', Icons.home),
            const SizedBox(height: 12),
            _buildTextField(_reasonController, 'Reason for Visit', Icons.edit),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitAppointment,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  'Create Appointment',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller, String label, IconData icon, {
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
