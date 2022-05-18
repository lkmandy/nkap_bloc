// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:nkap/colors/colors.dart';
//
// import '../../blocs/auth_bloc/auth_bloc.dart';
// import '../widgets/custom_button.dart';
// import '../widgets/custom_formfield.dart';
// import '../widgets/custom_header.dart';
// import '../widgets/custom_richtext.dart';
// import 'login.dart';
//
// class SignUp extends StatefulWidget {
//   const SignUp({Key? key}) : super(key: key);
//
//   @override
//   State<SignUp> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   final _formKey = GlobalKey<FormState>();
//   final _userName = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   String get userName => _userName.text.trim();
//   String get email => _emailController.text.trim();
//   String get password => _passwordController.text.trim();
//
//   void _authenticateWithEmailAndPassword(context) {
//     if (_formKey.currentState!.validate()) {
//       // If email is valid adding new event [SignUpRequested].
//       BlocProvider.of<AuthBloc>(context).add(
//         SignUpRequested(_emailController.text, _passwordController.text),
//       );
//     }
//   }
//
// //
//   void _authenticateWithGoogle(context) {
//     BlocProvider.of<AuthBloc>(context).add(
//       GoogleSignInRequested(),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.9,
//               width: MediaQuery.of(context).size.width,
//               decoration: const BoxDecoration(
//                   color: NkapColors.whiteShade,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(32),
//                       topRight: Radius.circular(32))),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomHeader(
//                         text: 'Sign Up',
//                         onTap: () {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const Login()));
//                         }),
//                     Container(
//                       height: 130,
//                       width: MediaQuery.of(context).size.width * 0.8,
//                       margin: EdgeInsets.only(
//                           left: MediaQuery.of(context).size.width * 0.09),
//                       child: Image.asset("assets/images/signup.png"),
//                     ),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                     // CustomFormField(
//                     //   headingText: "UserName",
//                     //   hintText: "username",
//                     //   suffixIcon: const SizedBox(),
//                     //   maxLines: 1,
//                     //   textInputType: TextInputType.text,
//                     //   controller: _userName,
//                     // ),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                     CustomFormField(
//                       headingText: "Email",
//                       hintText: "Email",
//                       suffixIcon: const SizedBox(),
//                       maxLines: 1,
//                       textInputAction: TextInputAction.done,
//                       textInputType: TextInputType.emailAddress,
//                       controller: _emailController,
//                       autovalidateMode:
//                       AutovalidateMode.onUserInteraction,
//                       validator: (value) {
//                         return value != null &&
//                             !EmailValidator.validate(value)
//                             ? 'Enter a valid email'
//                             : null;
//                       },
//                     ),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                     CustomFormField(
//                       maxLines: 1,
//                       textInputType: TextInputType.text,
//                       controller: _passwordController,
//                       headingText: "Password",
//                       hintText: "At least 8 Character",
//                       suffixIcon: IconButton(
//                           icon: const Icon(Icons.visibility), onPressed: () {}),
//                       autovalidateMode:
//                       AutovalidateMode.onUserInteraction,
//                       validator: (value) {
//                         return value != null && value.length < 6
//                             ? "Enter min. 6 characters"
//                             : null;
//                       },
//                     ),
//                     const SizedBox(
//                       height: 16,
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         _authenticateWithEmailAndPassword(context);
//                       },
//                       child: Center(child: const Text('Sign Up')),
//                     ),
//                     CustomRichText(
//                       discription: 'Already have an account? ',
//                       text: ' Log In',
//                       onTap: () {
//                         Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const Login()));
//                       },
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           // ],
//       ),
//     );
//   }
// }

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../widgets/custom_formfield.dart';
import '../widgets/custom_header.dart';
import '../widgets/custom_richtext.dart';
import 'coin.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            // Navigating to the dashboard screen if the user is authenticated
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Coin(),
              ),
            );
          }
          if (state is AuthError) {
            // Displaying the error message if the user is not authenticated
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            // Displaying the loading indicator while the user is signing up
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UnAuthenticated) {
            // Displaying the sign up form if the user is not authenticated
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomHeader(
                        text: 'Sign Up',
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                      ),
                      Container(
                        height: 190,
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.09),
                        child: Image.asset("assets/images/signup.png"),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomFormField(
                                key: const ValueKey('emailSignUpField'),
                                headingText: "Email",
                                hintText: "Email",
                                suffixIcon: const SizedBox(),
                                controller: _emailController,
                                maxLines: 1,
                                obscureText: false,
                                textInputType: TextInputType.emailAddress,
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null &&
                                          !EmailValidator.validate(value)
                                      ? 'Enter a valid email'
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomFormField(
                                key: const ValueKey('passwordSignUpField'),
                                controller: _passwordController,
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null && value.length < 6
                                      ? "Enter min. 6 characters"
                                      : null;
                                },
                                headingText: "Password",
                                hintText: "Password",
                                suffixIcon: Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                  child: GestureDetector(
                                    onTap: _toggle,
                                    child: Icon(
                                      _obscureText
                                          ? Icons.visibility_rounded
                                          : Icons.visibility_off_rounded,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                maxLines: 1,
                                obscureText: _obscureText,
                                textInputType: TextInputType.emailAddress,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _createAccountWithEmailAndPassword(
                                              context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: const Text('Sign Up'),
                                        ),
                                      ),
                                    ),
                                    CustomRichText(
                                      discription: "Already have an account? ",
                                      text: "Log In",
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const Login()));
                                      },
                                    ),
                                    // Text(
                                    //   'Or',
                                    //   style: TextStyle(fontSize: 16),
                                    // ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(16.0),
                                    //   child: IconButton(
                                    //     onPressed: () {
                                    //       _authenticateWithGoogle(context);
                                    //     },
                                    //     icon: Image.network(
                                    //       "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png",
                                    //       height: 30,
                                    //       width: 30,
                                    //     ),
                                    //   ),
                                    // ),
                                  ]),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  void _createAccountWithEmailAndPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(
          _emailController.text,
          _passwordController.text,
        ),
      );
    }
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }
}
