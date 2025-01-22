import 'package:flutter/material.dart';
import 'package:predictivehealthcare/api/registrationapi.dart';
import 'package:predictivehealthcare/login.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _gender;
  DateTime? _dob;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade200, Colors.green.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create Your Account',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),

                      // First Name Field
                      _buildTextField(
                        controller: _firstNameController,
                        label: 'First Name',
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your first name'
                            : null,
                      ),

                      // Last Name Field
                      _buildTextField(
                        controller: _lastNameController,
                        label: 'Last Name',
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your last name'
                            : null,
                      ),

                      // Date of Birth Field
                      _buildDatePicker(
                        label: 'Date of Birth',
                        value: _dob,
                        onChanged: (date) => setState(() => _dob = date),
                        validator: (value) => value == null
                            ? 'Please select your date of birth'
                            : null,
                      ),

                      // Gender Dropdown
                      _buildDropdownField(
                        label: 'Gender',
                        items: const ['Male', 'Female', 'Other'],
                        value: _gender,
                        onChanged: (value) => setState(() => _gender = value),
                        validator: (value) =>
                            value == null ? 'Please select your gender' : null,
                      ),

                      // Phone Field
                      _buildTextField(
                        controller: _phoneController,
                        label: 'Phone',
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your phone number'
                            : null,
                        keyboardType: TextInputType.phone,
                      ),

                      // Email Field
                      _buildTextField(
                        controller: _emailController,
                        label: 'Email',
                        validator: (value) => value == null ||
                                value.isEmpty ||
                                !value.contains('@')
                            ? 'Please enter a valid email address'
                            : null,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      // Address Field
                      _buildTextField(
                        controller: _addressController,
                        label: 'Address',
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your address'
                            : null,
                        maxLines: 3,
                      ),

                      // Password Field
                      _buildTextField(
                        controller: _passwordController,
                        label: 'Password',
                      ),

                      const SizedBox(height: 20),

                      // Sign Up Button
                      _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: _onSignUp,
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('Sign Up'),
                            ),

                      const SizedBox(height: 20),

                      // Login Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            },
                            child: const Text(
                              'Login here',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // TextField Builder
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          ),
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: maxLines,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // Dropdown Builder
  Widget _buildDropdownField({
    required String label,
    required List<String> items,
    String? value,
    void Function(String?)? onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          ),
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
          validator: validator,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // Date Picker Builder
  Widget _buildDatePicker({
    required String label,
    required DateTime? value,
    required void Function(DateTime) onChanged,
    required String? Function(DateTime?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (date != null) onChanged(date);
          },
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            ),
            child: Text(
              value == null
                  ? 'Select Date'
                  : '${value.day}/${value.month}/${value.year}',
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // Sign Up Button Handler
  void _onSignUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      final Map<String, dynamic> formData = {
        'firstname': _firstNameController.text,
        'lastname': _lastNameController.text,
        'email': _emailController.text,
        'mobile': _phoneController.text,
        'password': _passwordController.text,
        'gender': _gender,
        'address': _addressController.text,
        'dob': _dob.toString().substring(0, 10),
        'username':_emailController.text
      };
      print(formData);
      await registerUser(formData, context);
      setState(() => _isLoading = false);
    }
  }
}
