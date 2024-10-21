import 'package:flutter/material.dart';

void main() => runApp(BMICalculatorApp());

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primaryColor: Color(0xFF246AFE),
        scaffoldBackgroundColor: Color(0xFFD1D5DB),
      ),
      home: BMICalculatorScreen(),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  int weight = 70;
  int age = 23;
  String gender = "male";
  double height = 170; // height in cm
  double bmi = 0.0;
  String bmiCategory = '';

  void calculateBMI() {
    double heightInMeters = height / 100; // convert height to meters
    setState(() {
      bmi = weight / (heightInMeters * heightInMeters);
      bmiCategory = getBMICategory(bmi);
    });
  }

  String getBMICategory(double bmiValue) {
    if (bmiValue < 18.5) {
      return 'Underweight';
    } else if (bmiValue >= 18.5 && bmiValue < 24.9) {
      return 'Normal weight';
    } else if (bmiValue >= 25 && bmiValue < 29.9) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome 😊',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'BMI Calculator',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  genderButton('Male', Icons.male, gender == 'male', () {
                    setState(() {
                      gender = 'male';
                    });
                  }),
                  genderButton('Female', Icons.female, gender == 'female', () {
                    setState(() {
                      gender = 'female';
                    });
                  }),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  valueCard('Weight', weight, () {
                    setState(() {
                      weight = weight > 0 ? weight - 1 : 0;
                    });
                  }, () {
                    setState(() {
                      weight++;
                    });
                  }),
                  valueCard('Age', age, () {
                    setState(() {
                      age = age > 0 ? age - 1 : 0;
                    });
                  }, () {
                    setState(() {
                      age++;
                    });
                  }),
                ],
              ),
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Height',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10), 
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Height',
                        hintStyle: TextStyle(
                          color: Colors.grey, // Grey text for hint
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        border: InputBorder.none, // Remove the border
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        height = double.tryParse(value) ?? 0;
                      }, // Numeric keyboard for height
                    ),
                  ),
                ],
              ),
              SizedBox(height: 70),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    bmi == 0 ? '0' : bmi.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF246AFE),
                      height: 0.9,
                    ),
                  ),
                  Text(
                    bmi == 0 ? 'Category' : bmiCategory,
                    style: TextStyle(
                      color: Color(0xFF246AFE),
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      height: 0.9,
                    ),
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF246AFE), // Blue background color
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: calculateBMI,
                child: Text(
                  "Let's Go",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget genderButton(
      String title, IconData icon, bool isSelected, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 140,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF246AFE) : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black,
            ),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget valueCard(
      String label, int value, Function onDecrement, Function onIncrement) {
    return Container(
      width: 140,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            value.toString(),
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle_outline),
                onPressed: () => onDecrement(),
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline),
                onPressed: () => onIncrement(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
