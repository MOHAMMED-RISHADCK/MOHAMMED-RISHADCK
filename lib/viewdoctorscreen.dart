import 'package:flutter/material.dart';
import 'package:predictivehealthcare/api/viewpostapi.dart';
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
    _departments = ['All']; // Start with 'All' as the default option
    _departments.addAll(widget.doctors
        .map<String>((doctor) => doctor['specialization'] as String)
        .toSet()
        .toList());
  }

  // Filtered list
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
        title: const Text('Available Doctors'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: 'Search ',
                prefixIcon: const Icon(Icons.search, color: Colors.teal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: DropdownButtonFormField<String>(
              value: _selectedDepartment,
              items: _departments
                  .map((department) => DropdownMenuItem(
                        value: department,
                        child: Text(department),
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
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _filteredDoctors.isEmpty
                ? Center(
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
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.teal,
                            child:
                                const Icon(Icons.person, color: Colors.white),
                          ),
                          title: Text(
                            doctor['Name']!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              '${doctor['specialization']} • ${doctor['qualification']}'),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 18),
                              Text(
                                '${doctor['rating'] ?? 0.0}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          onTap: () async{
                            List<Map<String,dynamic>>slotdata=await    getSlots();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DoctorDetailsScreen(doctor: doctor,),
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
    );
  }
}
