import 'package:flutter/material.dart';
import '../data/app_data.dart';

class DashboardScreen extends StatefulWidget {
  final UserProfile userProfile;

  const DashboardScreen({super.key, required this.userProfile});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeTab(
        user: widget.userProfile,
        onTabChange: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      WorkoutTab(goal: widget.userProfile.goal),
      NutritionTab(goal: widget.userProfile.goal),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle(_currentIndex)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Workout'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant), label: 'Nutrition'),
        ],
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Workout Plan';
      case 2:
        return 'Nutrition Plan';
      default:
        return 'Health App';
    }
  }
}

class HomeTab extends StatelessWidget {
  final UserProfile user;
  final Function(int) onTabChange;

  const HomeTab({
    super.key,
    required this.user,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, ${user.name}!',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text('Goal: ${user.goal.displayName}'),
                  const SizedBox(height: 4),
                  Text('Current Stats: ${user.weightKg}kg • ${user.heightCm}cm • ${user.age} yrs'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Health Check / BMI Card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.health_and_safety, color: Colors.blue.shade700, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Health Check (BMI)',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              user.bmi.toStringAsFixed(1),
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getBmiColor(user.bmiCategory),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                user.bmiCategory,
                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Coach\'s Advice',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                const Icon(Icons.lightbulb, color: Colors.amber, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    ProgramData.getAdvice(user.goal),
                    style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Quick Actions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _ActionCard(
                  icon: Icons.play_circle_fill,
                  label: 'Start Workout',
                  color: Colors.orange.shade100,
                  onTap: () => onTabChange(1), // Switch to Workout Tab
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _ActionCard(
                  icon: Icons.local_dining,
                  label: 'Log Meal',
                  color: Colors.green.shade100,
                  onTap: () => onTabChange(2), // Switch to Nutrition Tab
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getBmiColor(String category) {
    switch (category) {
      case 'Underweight':
        return Colors.blue;
      case 'Normal Weight':
        return Colors.green;
      case 'Overweight':
        return Colors.orange;
      case 'Obese':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: Colors.black87),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkoutTab extends StatelessWidget {
  final FitnessGoal goal;

  const WorkoutTab({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    final workouts = ProgramData.workouts[goal] ?? [];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: workouts.length,
      itemBuilder: (context, index) {
        final exercise = workouts[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Text('${index + 1}', style: const TextStyle(color: Colors.white)),
            ),
            title: Text(exercise.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(exercise.setsReps, style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600)),
                Text(exercise.description),
              ],
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}

class NutritionTab extends StatelessWidget {
  final FitnessGoal goal;

  const NutritionTab({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    final meals = ProgramData.diets[goal] ?? [];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      meal.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green),
                      ),
                      child: Text(
                        meal.time,
                        style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.restaurant_menu, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(child: Text(meal.ingredients)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.local_fire_department, size: 16, color: Colors.orange),
                    const SizedBox(width: 8),
                    Text(
                      meal.calories,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
