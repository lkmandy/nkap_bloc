import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nkap/blocs/latest_transactions/latest_transactions_bloc.dart';
import 'package:nkap/data/repositories/btc_and_eth_latest_block_repository.dart';
import 'package:nkap/data/repositories/btc_and_eth_latest_transaction_repository.dart';

import '../../blocs/btc_and_eth_bloc/latest_bloc.dart';

class BitCoinTransactionDetails extends StatefulWidget {
  const BitCoinTransactionDetails({Key? key}) : super(key: key);

  @override
  State<BitCoinTransactionDetails> createState() =>
      _BitCoinTransactionDetailsState();
}

class _BitCoinTransactionDetailsState extends State<BitCoinTransactionDetails> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LatestBlockBloc(
            RepositoryProvider.of<LatestBlockRepository>(context),
          )..add(LoadLatestBlockEvent()),
          // ..add(LatestHash(blockHash:)),
        ),
        BlocProvider(
            create: (context) => LatestTransactionsBloc(
                (RepositoryProvider.of<LatestTransactionsRepository>(
                    context)))),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BTC Transactions'),
        ),
        body: BlocBuilder<LatestBlockBloc, LatestBlockState>(
          builder: (context, state) {
            if (state is LatestBlockLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LatestBlockLoadedState) {
              BlocProvider.of<LatestTransactionsBloc>(context).add(
                LatestHash(blockHash: state.latestBlock.hash ?? ""),
              );
            }

            return BlocBuilder<LatestTransactionsBloc, LatestTransactionsState>(
                builder: (context, state) {
              if (state is LatestTransactionsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is LatestTransactionsLoadedState) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Scrollbar(
                        child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(8),
                      itemCount: state.latestTransactions.transactions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: ListTile(
                            tileColor: Colors.white,
                            title: Text('Transaction ${index + 1}:'),
                            subtitle: Text(
                                'time: ${state.latestTransactions.transactions[index].transactionTimestamp.toString()} \nindex: ${state.latestTransactions.transactions[index].transactionIndex}'),
                            isThreeLine: true,
                            trailing: Text(
                                '${state.latestTransactions.transactions[index].transactionAmount.toString()} BTC'),
                          ),
                          onTap: () {},
                        );
                      },
                    )));
              }
              if (state is LatestTransactionsErrorState) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(state.error.toString()),
                  ),
                );
              }
              return const SizedBox();
            });
          },
        ),
      ),
    );
  }
}
