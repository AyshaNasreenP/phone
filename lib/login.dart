import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'color.dart';
import 'home.dart';
import 'otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String verify="";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    countryCodeController.text = "+91";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0x0),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 50, 1),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff2F2D30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const home()),
                );
              }, child: Text("Skip")),
            )
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height*1,
       width: MediaQuery.of(context).size.width*1,
      
                  decoration: BoxDecoration(
                  gradient: LinearGradient(
                  colors: [gradient1,gradient2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  )
                  ),
      
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   'assets/img.jpeg',
                  //   width: 150,
                  //   height: 150,
                  // ),
                  SizedBox(height: 25),
                  Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,
                    color: textColor),
                  ),
                  SizedBox(height: 10),
                  // Text(
                  //   "We need to register your phone before getting started!",
                  //   style: TextStyle(fontSize: 16),
                  //   textAlign: TextAlign.center,
                  // ),
                  SizedBox(height: 30),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        SizedBox(
                          width: 40,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                countryCodeController.text = value;
                              });
                            },
                            controller: countryCodeController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Text(
                          "|",
                          style: TextStyle(fontSize: 33, color: Colors.grey),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Phone",
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff2F2D30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: "${countryCodeController.text + phoneController.text}",
                        verificationCompleted: (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          LoginScreen.verify=verificationId;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const otpverify()),
                          );
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },
                    child: Text("Get OTP",
                        style: TextStyle(fontSize: 18,
                            color:Color(0xff9A03A8),
                            fontWeight: FontWeight.bold)
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
//
// import 'otp.dart';
// class login extends StatefulWidget {
//   const login({super.key});
//
//   @override
//   State<login> createState() => _loginState();
// }
//
// class _loginState extends State<login> {
//   TextEditingController countrycode = TextEditingController();
//   var phone="";
//   @override
//   void initState() {
//     // TODO: implement initState
//     countrycode.text = "+91";
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         margin: EdgeInsets.only(left: 25, right: 25),
//         alignment: Alignment.center,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/img.jpeg',
//                 width: 150,
//                 height: 150,
//               ),
//               SizedBox(
//                 height: 25,
//               ),
//               Text(
//                 "Phone Verification",
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "We need to register your phone without getting started!",
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Container(
//                 height: 55,
//                 decoration: BoxDecoration(
//                     border: Border.all(width: 1, color: Colors.grey),
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       width: 10,
//                     ),
//                     SizedBox(
//                       width: 40,
//                       child: Expanded(
//                         child: TextField(
//                           onChanged: (value){
//                             phone=value;
//                           },
//                           controller: countrycode,
//                           keyboardType: TextInputType.phone,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Text(
//                       "|",
//                       style: TextStyle(fontSize: 33, color: Colors.grey),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     TextField(
//                       keyboardType: TextInputType.phone,
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: "Phone",
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       primary: Colors.green.shade600,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10))),
//                   onPressed: () async {
//                     await FirebaseAuth.instance.verifyPhoneNumber(
//                       phoneNumber: "${countrycode.text + phone}",
//                       verificationCompleted: (PhoneAuthCredential credential) {},
//                       verificationFailed: (FirebaseAuthException e) {},
//                       codeSent: (String verificationId, int? resendToken) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => const otpverify()),
//                         );
//                       },
//                       codeAutoRetrievalTimeout: (String verificationId) {},
//                     );
//
//                   },
//                   child: Text("Get OTP"))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
