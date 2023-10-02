import 'package:flutter/material.dart';
import 'package:todohive/homepage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'user_model.dart';

class AuthenticationPage extends StatelessWidget {
  final TextEditingController _username= TextEditingController();
  final TextEditingController _password= TextEditingController();

  void _login(BuildContext context) async {
    var box = await Hive.openBox('mybox');
    String username = _username.text;
    String password = _password.text;

    // Simulated authentication (you can replace this with a real authentication logic)
    List<User> users = [
      User('user1', 'password1'),
      User('user2', 'password2'),
      User('user3','password3'),
    ];

    User? user = users.firstWhere((user) => user.username == username && user.password == password,);

    if (user != null) {
      box.put('loggedInUser', user.username);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepage()));
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid credentials')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(
        child: Text('Authentication Form',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
        backgroundColor: Colors.blue[500],
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),

          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(controller: _username, decoration: InputDecoration(labelText: 'Username')),
                TextField(controller: _password, decoration: InputDecoration(labelText: 'Password')),
                SizedBox(height: 35),
                ElevatedButton(
                  onPressed: () => _login(context),
                  child: Text('Login'),
                ),
                SizedBox(height: 35,),
              ],
            ),
          ),
          Container(
            color: Colors.blueAccent,
            height: 200,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Image.asset('/images/img1.png', height: 150, width: 150),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
