import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:myworking_app/API/prediction.dart';
import 'package:myworking_app/Screens/Auth/login.dart';

class Questionnaire extends StatefulWidget {
  @override
  _QuestionnaireState createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  int currentQuestionIndex = 0;
  List<String> questions = [
    "Does your age more than 60?",
    "Is it cold outside?",
    "Are you experiencing any anxiety?",
    "Have you done any activity that may have affected your motor skills?",
  ];
  List<String?> answers = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFF009DD1),
          title: Text(
            "ParkinCare",
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(color: Colors.white, size: 30),
        ),
        bottomNavigationBar: const GNav(
            gap: 8,
            backgroundColor: Color(0xFF009DD1),
            color: Colors.white,
            activeColor: Colors.white,
            tabs: [
              GButton(
                icon: Icons.home,
                text: "Home",
              ),
              GButton(
                icon: Icons.settings,
                text: "Settings",
              ),
              GButton(
                icon: Icons.person,
                text: "Profile",
              ),
              GButton(
                icon: Icons.help,
                text: "Help",
              )
            ]),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: (currentQuestionIndex + 1) / (questions.length + 1),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 5.0,
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20.0),
                      Text(
                        "Question ${currentQuestionIndex + 1}/${questions.length}",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        questions[currentQuestionIndex],
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () => answerQuestion("Yes"),
                        child: Text("Yes"),
                      ),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () => answerQuestion("No"),
                        child: Text("No"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void answerQuestion(String answer) {
    setState(() {
      answers.add(answer);

      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        showResult();
      }
    });
  }

  void showResult() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Report"),
          content: Column(
            children: [
              for (int i = 0; i < questions.length; i++)
                ListTile(
                  title: Text("Question ${i + 1}: ${questions[i]}"),
                  subtitle: Text("Answer: ${answers[i]}"),
                ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
            ElevatedButton(
              onPressed: () {
                // Reset the questionnaire and start again
                setState(() {
                  currentQuestionIndex = 0;
                  answers.clear();
                });
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => UploadImage(),
                  ),
                ); // Close the current dialog
              },
              child: Text("Take Test"),
            ),
          ],
        );
      },
    );
  }
}
