import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/core/theme/text_theme.dart';
import 'package:bank/src/core/widgets/custom_appbar.dart';
import 'package:bank/src/features/coins/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:bank/src/features/coins/repositories/crypto_coins/abstract_coins_repository.dart';
import 'package:bank/src/features/coins/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

import '../widgets/widgets.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  List<CryptoCoin>? _cryptoCoinsList;

  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());

  @override
  void initState() {
    _loadCryptoCoins();
    _cryptoListBloc.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const CustomAppBar(
          title: 'Investment',
          backgroundColor: Colors.transparent,
          popAble: true),
      body: (_cryptoCoinsList == null)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SvgPicture.asset('assets/icons/cripto.svg'),
                  Container(
                    width: double.infinity,
                    height: 500,
                    decoration: BoxDecoration(
                        color: Color(0xffDBDBDB),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(26),
                            topRight: Radius.circular(26))),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transactions',
                            style: TextStyles.simpleText.copyWith(
                                color: AppColors.sectionColor,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.only(top: 16),
                              itemCount: _cryptoCoinsList!.length,
                              separatorBuilder: (context, index) => Divider(
                                color: theme.dividerColor,
                              ),
                              itemBuilder: (context, i) {
                                final coin = _cryptoCoinsList![i];
                                return CryptoCoinTile(coin: coin);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Future<void> _loadCryptoCoins() async {
    _cryptoCoinsList = await GetIt.I<AbstractCoinsRepository>().getCoinsList();
    setState(() {});
  }
}
