import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nkap/ui/screens/signup.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../widgets/custom_formfield.dart';
import '../widgets/custom_header.dart';
import '../widgets/custom_richtext.dart';
import 'coin.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _SignInState();
}

class _SignInState extends State<Login> {
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
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            // Navigating to the dashboard screen if the user is authenticated
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Coin()));
          }
          if (state is AuthError) {
            // Showing the error message if the user has entered invalid credentials
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              // Showing the loading indicator while the user is signing in
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenticated) {
              // Showing the sign in form if the user is not authenticated
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomHeader(
                          text: 'Log In',
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()));
                          },
                        ),
                        Container(
                          height: 190,
                          width: MediaQuery.of(context).size.width * 0.8,
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.09),
                          child: Image.asset("assets/images/login.png"),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(24.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _authenticateWithEmailAndPassword(
                                              context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: const Text('Log In'),
                                        ),
                                      ),
                                    ),

                                    // Text('Or', style: TextStyle(fontSize: 16),),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(left: 8.0),
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
                                    // Text('Sign In With Google', style: TextStyle(fontSize: 8,)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        CustomRichText(
                          discription: "Don't have an account? ",
                          text: "Sign Up",
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()));
                          },
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
      ),
    );
  }

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(_emailController.text, _passwordController.text),
      );
    }
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }
}
