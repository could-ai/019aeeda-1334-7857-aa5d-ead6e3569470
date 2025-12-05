import 'package:flutter/material.dart';
import '../data/app_data.dart';
import 'dashboard_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  FitnessGoal _selectedGoal = FitnessGoal.loseWeight;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final user = UserProfile(
        name: _nameController.text,
        age: int.parse(_ageController.text),
        heightCm: double.parse(_heightController.text),
        weightKg: double.parse(_weightController.text),
        goal: _selectedGoal,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(userProfile: user),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Plan'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Tell us about yourself',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.cake),
                      ),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Weight (kg)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.monitor_weight),
                      ),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Height (cm)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.height),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter your height' : null,
              ),
              const SizedBox(height: 24),
              const Text(
                'What is your main goal?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<FitnessGoal>(
                value: _selectedGoal,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
                items: FitnessGoal.values.map((goal) {
                  return DropdownMenuItem(
                    value: goal,
                    child: Text(goal.displayName),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGoal = value!;
                  });
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Generate My Program',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
