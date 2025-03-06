import 'package:flutter/material.dart';

class PrescriptionScreen extends StatelessWidget {
  // Mock prescription data
  final List<Map<String, dynamic>> prescriptions;

  const PrescriptionScreen({super.key, required this.prescriptions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescriptions'),
        backgroundColor: Colors.blueAccent,
      ),
      body: prescriptions.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: prescriptions.length,
              itemBuilder: (context, index) {
                final prescription = prescriptions[index];
                final medicines = prescription['MEDICINES'] as List<dynamic>;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 6.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.local_hospital,
                                size: 36.0, color: Colors.blueAccent),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Prescribed by: ${prescription['DOCTOR DETAILS']['NAME'] ?? "Unknown"}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    medicines.isNotEmpty
                                        ? 'Date: ${medicines[0]['isssuedate'] ?? "N/A"}'
                                        : 'No issuance date available',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Medications:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        medicines.isNotEmpty
                            ? Column(
                                children: medicines.map<Widget>((medication) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(vertical: 6.0),
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.medication,
                                            color: Colors.blueAccent, size: 24.0),
                                        const SizedBox(width: 12.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                medication['NAME'] ?? "Unknown Medicine",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              Text('Dosage: ${medication['DOSE'] ?? "N/A"}'),
                                              Text('Disease: ${medication['DESCRIPTION'] ?? "N/A"}'),
                                              Text(
                                                medication['remark'] ?? "",
                                                style: const TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              )
                            : const Text(
                                "No medicines prescribed",
                                style: TextStyle(fontSize: 14.0, color: Colors.grey),
                              ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text(
                'No Prescriptions Found',
                style: TextStyle(fontSize: 18.0, color: Colors.grey),
              ),
            ),
    );
  }
}
