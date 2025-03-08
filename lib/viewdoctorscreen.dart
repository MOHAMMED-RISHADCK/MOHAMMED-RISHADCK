import 'package:flutter/material.dart';
import 'package:predictivehealthcare/api/viewslotapi.dart';
import 'package:predictivehealthcare/doctordetailscreen.dart';

class AvailableDoctorsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> doctors;
  const AvailableDoctorsScreen({super.key, required this.doctors});

  @override
  _AvailableDoctorsScreenState createState() => _AvailableDoctorsScreenState();
}

class _AvailableDoctorsScreenState extends State<AvailableDoctorsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedDepartment = 'All';
  late List<String> _departments;

  @override
  void initState() {
    super.initState();
    _departments = ['All']; // Default option
    _departments.addAll(widget.doctors
        .map<String>((doctor) => doctor['specialization'] as String)
        .toSet()
        .toList());
  }

  List<Map<String, dynamic>> get _filteredDoctors {
    String search = _searchController.text.toLowerCase();
    return widget.doctors.where((doctor) {
      bool matchesSearch = doctor['Name']!.toLowerCase().contains(search);
      bool matchesDepartment = _selectedDepartment == 'All' ||
          doctor['specialization'] == _selectedDepartment;
      return matchesSearch && matchesDepartment;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Doctors',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: 'Search by Name',
                prefixIcon: const Icon(Icons.search, color: Colors.teal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedDepartment,
              items: _departments
                  .map((dept) => DropdownMenuItem(
                        value: dept,
                        child: Text(dept),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDepartment = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Select Department',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _filteredDoctors.isEmpty
                  ? const Center(
                      child: Text(
                        'No doctors found',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredDoctors.length,
                      itemBuilder: (context, index) {
                        final doctor = _filteredDoctors[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: const CircleAvatar(
                              backgroundColor: Colors.teal,
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            title: Text(
                              doctor['Name']!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            subtitle: Text(
                                '${doctor['specialization']} • ${doctor['qualification']}'),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 20),
                                Text(
                                  '${doctor['avg_rating'] ?? 0.0}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () async {
                              List<Map<String, dynamic>> slotdata =
                                  await getSlots();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorDetailsScreen(
                                    doctor: doctor,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}