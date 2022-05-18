import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:nkap/colors/colors.dart';
import 'package:nkap/ui/screens/bitcoin_transaction_details.dart';
import 'package:nkap/ui/screens/ethereum_transaction_details.dart';
import 'package:nkap/ui/screens/tezos_transaction_details.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import 'login.dart';

class Coin extends StatefulWidget {
  static final List<String> cryptoCardImages = <String>[
    'assets/images/bitcoin.png',
    'assets/images/tezos.png',
    'assets/images/ethereum.png',
  ];

  @override
  State<Coin> createState() => _CoinState();
}

class _CoinState extends State<Coin> {
  final List cryptos = [
    ['Bitcoin', BitCoinTransactionDetails()],
    ['Tezos', TezosTransactionDetails()],
    ['Ethereum', EthereumTransactionDetails()],
  ];

  final List<String> cryptoShortNames = <String>['BTC', 'XTZ', 'ETH'];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Coins",
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              key: const ValueKey('LogoutKey'),
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () {
                _signOut(context);
              },
            ),
          ),
        ],
        centerTitle: false,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            // Navigate to the sign in screen when the user Signs Out
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Login()),
                  (route) => false,
            );
          }
        },
        child: Scrollbar(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(8),
              itemCount: cryptos.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => cryptos[index][1]),
                    );
                  },
                  child: GFCard(
                    boxFit: BoxFit.cover,
                    image: Image.asset(Coin.cryptoCardImages[index]),
                    showImage: true,
                    title: GFListTile(
                      title: Text(
                        cryptos[index][0].toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          color: NkapColors.accent,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      subTitle: Row(
                        children: <Widget>[
                          Text(
                            'View all ${cryptoShortNames[index]} transactions',
                            style: const TextStyle(color: NkapColors.light),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          const Icon(
                            Icons.double_arrow,
                            color: NkapColors.accent,
                            size: 18,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  Future<void> _signOut(context) async {
    BlocProvider.of<AuthBloc>(context).add(
        SignOutRequested()
    );
  }
}
