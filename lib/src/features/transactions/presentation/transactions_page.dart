import 'package:bank/src/core/colors/app_colors.dart';
import 'package:bank/src/core/widgets/custom_appbar.dart';
import 'package:bank/src/features/main/presentation/bloc/message_bloc/message_bloc.dart';
import 'package:bank/src/features/transactions/widgets/message_tile_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsPage extends StatefulWidget {
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'History',
        backgroundColor: AppColors.mainColor,
        popAble: false,
      ),
      body: BlocProvider(
        create: (context) => MessageBloc()..add(LoadMessagesEvent()),
        child: BlocBuilder<MessageBloc, MessageState>(
          builder: (context, state) {
            if (state is LoadingMessageState) {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColors.buttonColor,
              ));
            } else if (state is FailureMessageState) {
              return Center(child: Text('Error: ${state.error}'));
            } else if (state is SuccessMessageState) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: false,
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final message = state.items[index];
                        return MessageTileWidget(
                          isMe: false,
                          username: message.username,
                          message: message.messages,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
