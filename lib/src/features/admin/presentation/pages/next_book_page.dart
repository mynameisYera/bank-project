import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradus/src/core/colors/app_colors.dart';
import 'package:gradus/src/core/widgets/custom_appbar.dart';
import 'package:gradus/src/core/widgets/custom_button.dart';
import 'package:gradus/src/features/admin/widgets/admin_fields_widget.dart';
import 'package:gradus/src/features/main/presentation/bloc/next_book_bloc/next_book_bloc.dart';
import 'package:gradus/src/features/main/widgets/vote_tile_widget.dart';

class NextBookPage extends StatelessWidget {
  final TextEditingController bookNameController = TextEditingController();
  final TextEditingController pagesController = TextEditingController();

  NextBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.sectionColor,
      appBar: CustomAppBar(
        title: 'Next Book',
        popAble: true,
        backgroundColor: AppColors.sectionColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            AdminFieldsWidget(
              title: 'Book Name',
              hint: 'Name of book',
              controller: bookNameController,
            ),
            AdminFieldsWidget(
              title: 'Book Pages',
              hint: 'Pages',
              controller: pagesController,
            ),
            SizedBox(height: 20),
            CustomButton(
              onTap: () async {
                String bookName = bookNameController.text;
                int? pages = int.tryParse(pagesController.text);

                if (bookName.isNotEmpty && pages != null) {
                  await FirebaseFirestore.instance.collection('nextBook').add({
                    'name': bookName,
                    'page': pages,
                    'vote': 0,
                    'voters': [],
                  });

                  bookNameController.clear();
                  pagesController.clear();

                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Please fill in all fields correctly.')),
                  );
                }
              },
              btnText: 'Publish',
            ),
            SizedBox(height: 50),
            BlocProvider(
              create: (context) => NextBookBloc()..add(LoadNextBookEvent()),
              child: BlocBuilder<NextBookBloc, NextBookState>(
                builder: (context, state) {
                  if (state is LoadingNextBookState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.buttonColor,
                      ),
                    );
                  }
                  if (state is SuccessNextBookState) {
                    return SizedBox(
                        height: (77 * state.items.length) +
                            (20 * state.items.length.toDouble()),
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.items.length,
                          itemBuilder: (context, index) {
                            final book = state.items[index];
                            return Dismissible(
                              key: Key(book.id),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                              onDismissed: (direction) async {
                                await FirebaseFirestore.instance
                                    .collection('nextBook')
                                    .doc(book.id)
                                    .delete();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('${book.name} deleted')),
                                );

                                context
                                    .read<NextBookBloc>()
                                    .add(LoadNextBookEvent());
                              },
                              child: VoteTileWidget(
                                onTap: () {},
                                bookName: book.name,
                                page: book.page,
                                vote: book.vote,
                              ),
                            );
                          },
                        ));
                  } else {
                    return CustomButton(
                      onTap: () {},
                      btnText: 'You already voted',
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
