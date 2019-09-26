 
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/rendering.dart';
  import 'main.dart';
  class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {

  void submit(){
    print("sup");
  }

  //Store values into these variables upon entering them into field
  String _email, _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(widget.title),
        textTheme: TextTheme(
          title: TextStyle(color: Colors.greenAccent, fontSize: 25.0, fontFamily: 'roboto')
        ),
      ),
      //Added a form which will have a key to save input
      body: Form(
        key: _formKey, //Formkey to save input
        //Formats input fields in a container with a padding to clean it up
        child: new Container(
           padding: new EdgeInsets.all(25.0), 
        //Added a column in the center of the screen
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Added textboxes with an icon
            TextFormField(
              decoration: new InputDecoration(
                icon: Icon(Icons.email, color: Colors.black), 
                helperText: "Email", 
                focusedBorder:UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.greenAccent, width: 2.0),
                ),
                ),
              cursorColor: Colors.black,
              
              validator: (input){
                if (input.isEmpty) {
                  return "Please enter an Email.";
                }
              },
              onSaved: (input) => _email = input,
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.lock, color: Colors.black), 
                helperText: "Password", 
                focusedBorder:UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.greenAccent, width: 2.0),
                ),
                ),
              cursorColor: Colors.black,
              validator: (input){
                if (input.length < 6) {
                  return "Please enter a Password at least 6 characters.";
                }
              },
              onSaved: (input) => _password = input,
              obscureText: true,
              ),
              //Added a submit button that goes to the next page upon press
              //and authenticates email and password
              MaterialButton(
                //Login button with styling
                onPressed: login,
                elevation: 5,
                minWidth: 200,
                color: Colors.greenAccent,
                //Labels the button with Submit
                child: Text('Submit'),
                ),
                MaterialButton(
                  //Register button with styling
                  onPressed: () {},
                child: Text('Create an account'),
                ),
          ],
        ),
      ),),
    );
  }
  Future<void> login() async
  {
    final formState = _formKey.currentState;
    //Validates the textfields with the validators that we had specified.
    //It will be under the textformfield called validator, we will need
    //to add more.
    if (formState.validate()) {
      //Firebase stuff
      formState.save();
      try {
      FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
      Navigator.push(context,
      new MaterialPageRoute(builder: (context) => MyHomePage(title: 'EasyGrocery')),
      );
      } catch (e) {
        print(e.message);
      }
    }
  }
}
