import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nkap/colors/colors.dart';
import 'package:nkap/data/repositories/btc_and_eth_latest_transaction_repository.dart';
import 'package:nkap/data/repositories/tezos_repository.dart';
import 'package:nkap/ui/screens/bitcoin_transaction_details.dart';
import 'package:nkap/ui/screens/coin.dart';
import 'package:nkap/ui/screens/ethereum_transaction_details.dart';
import 'package:nkap/ui/screens/login.dart';
import 'package:nkap/ui/screens/signup.dart';
import 'package:nkap/ui/screens/tezos_transaction_details.dart';

import 'blocs/auth_bloc/auth_bloc.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/btc_and_eth_latest_block_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCldFSqkkUSTs8rQgVrQHKZSGUMHFGB40M",
      appId: "1:174081459381:ios:5f4217af5c1bfa4e38aafc",
      messagingSenderId: "174081459381",
      projectId: "nkap-add56",
    ),
  );
  runApp(Nkap());
}

class Nkap extends StatefulWidget {
  @override
  State<Nkap> createState() => _NkapState();
}

class _NkapState extends State<Nkap> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => LatestBlockRepository(),
        ),
        RepositoryProvider(
          create: (context) => LatestTransactionsRepository(),
        ),
        RepositoryProvider(
          create: (context) => TezosBlockRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) =>
            AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
        child: MaterialApp(
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.
                if (snapshot.hasData) {
                  return Coin();
                }
                // Otherwise, they're not signed in. Show the sign in page.
                return Login();
              }),
          debugShowCheckedModeBanner: false,
          title: 'Nkap',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: NkapColors.primary,
              secondary: NkapColors.secondary,
            ),
          ),
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/signup': (context) => SignUp(),
            // When navigating to the "/second" route, build the SecondScreen widget.
            '/bitcoin_details': (context) => BitCoinTransactionDetails(),
            '/ethereum_details': (context) => EthereumTransactionDetails(),
            '/tezos_details': (context) => TezosTransactionDetails(),
            '/coin': (context) => Coin(),
            '/login': (context) => Login(),
          },
        ),
      ),
    );
  }
}
