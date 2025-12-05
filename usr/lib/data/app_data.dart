enum FitnessGoal {
  loseWeight,
  gainWeight,
  buildMuscle,
  getAbs,
  getCalves,
  bigShoulders,
  getTaller,
}

extension FitnessGoalExtension on FitnessGoal {
  String get displayName {
    switch (this) {
      case FitnessGoal.loseWeight:
        return 'Lose Weight';
      case FitnessGoal.gainWeight:
        return 'Gain Weight';
      case FitnessGoal.buildMuscle:
        return 'Build Muscle';
      case FitnessGoal.getAbs:
        return 'Get Abs';
      case FitnessGoal.getCalves:
        return 'Get Bigger Calves';
      case FitnessGoal.bigShoulders:
        return 'Build Big Shoulders';
      case FitnessGoal.getTaller:
        return 'Get Taller (Posture & Growth)';
    }
  }
}

class UserProfile {
  String name;
  int age;
  double heightCm;
  double weightKg;
  FitnessGoal goal;

  UserProfile({
    required this.name,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.goal,
  });

  double get bmi => weightKg / ((heightCm / 100) * (heightCm / 100));

  String get bmiCategory {
    final value = bmi;
    if (value < 18.5) return 'Underweight';
    if (value < 25) return 'Normal Weight';
    if (value < 30) return 'Overweight';
    return 'Obese';
  }
}

class Exercise {
  final String name;
  final String setsReps;
  final String description;

  Exercise({
    required this.name,
    required this.setsReps,
    required this.description,
  });
}

class Meal {
  final String name;
  final String time;
  final String ingredients;
  final String calories;

  Meal({
    required this.name,
    required this.time,
    required this.ingredients,
    required this.calories,
  });
}

class ProgramData {
  static Map<FitnessGoal, List<Exercise>> workouts = {
    FitnessGoal.loseWeight: [
      Exercise(name: 'Jump Rope', setsReps: '3 sets x 2 mins', description: 'High intensity cardio to burn calories.'),
      Exercise(name: 'Burpees', setsReps: '3 sets x 15 reps', description: 'Full body explosive movement.'),
      Exercise(name: 'Mountain Climbers', setsReps: '3 sets x 45 secs', description: 'Core and cardio blend.'),
      Exercise(name: 'Squat Jumps', setsReps: '3 sets x 15 reps', description: 'Explosive leg power.'),
    ],
    FitnessGoal.gainWeight: [
      Exercise(name: 'Heavy Squats', setsReps: '5 sets x 5 reps', description: 'Compound movement for overall mass.'),
      Exercise(name: 'Deadlifts', setsReps: '4 sets x 6 reps', description: 'Posterior chain builder.'),
      Exercise(name: 'Bench Press', setsReps: '4 sets x 8 reps', description: 'Upper body mass builder.'),
      Exercise(name: 'Overhead Press', setsReps: '4 sets x 8 reps', description: 'Shoulder and core stability.'),
    ],
    FitnessGoal.buildMuscle: [
      Exercise(name: 'Barbell Rows', setsReps: '4 sets x 10 reps', description: 'Back thickness.'),
      Exercise(name: 'Incline Dumbbell Press', setsReps: '4 sets x 10 reps', description: 'Upper chest development.'),
      Exercise(name: 'Lunges', setsReps: '3 sets x 12 reps per leg', description: 'Leg hypertrophy.'),
      Exercise(name: 'Pull Ups', setsReps: '3 sets to failure', description: 'Back width.'),
    ],
    FitnessGoal.getAbs: [
      Exercise(name: 'Hanging Leg Raises', setsReps: '4 sets x 12 reps', description: 'Targets lower abs.'),
      Exercise(name: 'Cable Crunches', setsReps: '4 sets x 15 reps', description: 'Weighted ab work.'),
      Exercise(name: 'Plank', setsReps: '3 sets x 60 secs', description: 'Core stability.'),
      Exercise(name: 'Russian Twists', setsReps: '3 sets x 20 reps', description: 'Obliques focus.'),
    ],
    FitnessGoal.getCalves: [
      Exercise(name: 'Standing Calf Raises', setsReps: '5 sets x 15 reps', description: 'Heavy loading for calves.'),
      Exercise(name: 'Seated Calf Raises', setsReps: '4 sets x 20 reps', description: 'Targets the soleus muscle.'),
      Exercise(name: 'Jump Rope', setsReps: '10 mins daily', description: 'Constant tension on calves.'),
      Exercise(name: 'Single Leg Calf Raise', setsReps: '3 sets x 12 reps', description: 'Isolation and balance.'),
    ],
    FitnessGoal.bigShoulders: [
      Exercise(name: 'Military Press', setsReps: '4 sets x 8 reps', description: 'Overall shoulder mass.'),
      Exercise(name: 'Lateral Raises', setsReps: '4 sets x 15 reps', description: 'Side delt width.'),
      Exercise(name: 'Face Pulls', setsReps: '4 sets x 15 reps', description: 'Rear delts and posture.'),
      Exercise(name: 'Front Raises', setsReps: '3 sets x 12 reps', description: 'Front delt isolation.'),
    ],
    FitnessGoal.getTaller: [
      Exercise(name: 'Cobra Stretch', setsReps: '3 sets x 30 secs', description: 'Stretches spine and abs.'),
      Exercise(name: 'Hanging Decompression', setsReps: '3 sets x 45 secs', description: 'Decompresses spinal discs.'),
      Exercise(name: 'Pelvic Shift', setsReps: '3 sets x 20 reps', description: 'Corrects lower back posture.'),
      Exercise(name: 'Supermans', setsReps: '3 sets x 15 reps', description: 'Strengthens lower back for upright posture.'),
    ],
  };

  static Map<FitnessGoal, List<Meal>> diets = {
    FitnessGoal.loseWeight: [
      Meal(name: 'Breakfast', time: '8:00 AM', ingredients: 'Oatmeal, Berries, Black Coffee', calories: '300 kcal'),
      Meal(name: 'Lunch', time: '1:00 PM', ingredients: 'Grilled Chicken Salad, Olive Oil Dressing', calories: '450 kcal'),
      Meal(name: 'Dinner', time: '7:00 PM', ingredients: 'Steamed Fish, Broccoli, Quinoa', calories: '400 kcal'),
    ],
    FitnessGoal.gainWeight: [
      Meal(name: 'Breakfast', time: '7:30 AM', ingredients: '4 Eggs, Toast, Avocado, Whole Milk', calories: '700 kcal'),
      Meal(name: 'Lunch', time: '12:30 PM', ingredients: 'Steak, Rice, Beans, Cheese', calories: '900 kcal'),
      Meal(name: 'Snack', time: '4:00 PM', ingredients: 'Protein Shake, Peanut Butter, Banana', calories: '500 kcal'),
      Meal(name: 'Dinner', time: '8:00 PM', ingredients: 'Salmon, Sweet Potato, Pasta', calories: '800 kcal'),
    ],
    FitnessGoal.buildMuscle: [
      Meal(name: 'Breakfast', time: '8:00 AM', ingredients: 'Egg Whites, Turkey Bacon, Toast', calories: '500 kcal'),
      Meal(name: 'Post-Workout', time: '11:00 AM', ingredients: 'Whey Protein, Dextrose/Banana', calories: '300 kcal'),
      Meal(name: 'Lunch', time: '1:30 PM', ingredients: 'Chicken Breast, Brown Rice, Asparagus', calories: '600 kcal'),
      Meal(name: 'Dinner', time: '7:30 PM', ingredients: 'Lean Beef, Mixed Veggies, Potato', calories: '650 kcal'),
    ],
    FitnessGoal.getAbs: [
      Meal(name: 'Breakfast', time: '8:00 AM', ingredients: 'Greek Yogurt, Blueberries, Almonds', calories: '350 kcal'),
      Meal(name: 'Lunch', time: '1:00 PM', ingredients: 'Tuna Salad, Spinach, Low-fat Dressing', calories: '400 kcal'),
      Meal(name: 'Dinner', time: '7:00 PM', ingredients: 'Grilled Chicken, Zucchini Noodles', calories: '350 kcal'),
    ],
    FitnessGoal.getCalves: [
      Meal(name: 'Breakfast', time: '8:00 AM', ingredients: 'Eggs, Spinach, Whole Grain Toast', calories: '500 kcal'),
      Meal(name: 'Lunch', time: '1:00 PM', ingredients: 'Turkey Burger, Sweet Potato Fries', calories: '600 kcal'),
      Meal(name: 'Dinner', time: '7:00 PM', ingredients: 'Chicken Thighs, Rice, Peas', calories: '600 kcal'),
    ],
    FitnessGoal.bigShoulders: [
      Meal(name: 'Breakfast', time: '8:00 AM', ingredients: 'Omelette with Cheese, Ham', calories: '550 kcal'),
      Meal(name: 'Lunch', time: '1:00 PM', ingredients: 'Beef Stir-fry, White Rice', calories: '700 kcal'),
      Meal(name: 'Dinner', time: '7:00 PM', ingredients: 'Salmon, Quinoa, Roasted Peppers', calories: '600 kcal'),
    ],
    FitnessGoal.getTaller: [
      Meal(name: 'Breakfast', time: '8:00 AM', ingredients: 'Milk, Eggs (Vitamin D & Calcium)', calories: '450 kcal'),
      Meal(name: 'Lunch', time: '1:00 PM', ingredients: 'Spinach Salad, Chicken (Protein)', calories: '500 kcal'),
      Meal(name: 'Snack', time: '4:00 PM', ingredients: 'Yogurt, Nuts (Zinc & Magnesium)', calories: '300 kcal'),
      Meal(name: 'Dinner', time: '7:00 PM', ingredients: 'Fish, Beans, Leafy Greens', calories: '500 kcal'),
    ],
  };

  static String getAdvice(FitnessGoal goal) {
    switch (goal) {
      case FitnessGoal.loseWeight:
        return "Focus on a caloric deficit. Eat high volume, low calorie foods.";
      case FitnessGoal.gainWeight:
        return "You must be in a caloric surplus. Don't skip meals!";
      case FitnessGoal.buildMuscle:
        return "Progressive overload is key. Increase weight or reps every week.";
      case FitnessGoal.getAbs:
        return "Abs are made in the kitchen. Low body fat is essential to see them.";
      case FitnessGoal.getCalves:
        return "Calves respond to high volume and frequency. Train them 3-4x a week.";
      case FitnessGoal.bigShoulders:
        return "Shoulders have 3 heads (front, side, rear). Hit all of them.";
      case FitnessGoal.getTaller:
        return "Maximize your genetic potential with good posture, sleep (HGH release), and nutrition.";
    }
  }
}
