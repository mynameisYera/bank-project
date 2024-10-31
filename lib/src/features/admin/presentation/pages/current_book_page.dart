import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradus/src/core/colors/app_colors.dart';
import 'package:gradus/src/core/widgets/custom_appbar.dart';
import 'package:gradus/src/core/widgets/custom_button.dart';
import 'package:gradus/src/features/admin/widgets/admin_fields_widget.dart';
import 'package:gradus/src/features/main/presentation/bloc/current_bloc/current_bloc.dart';
import 'package:gradus/src/features/main/presentation/bloc/news_bloc/news_bloc.dart';
import 'package:gradus/src/features/main/widgets/current_book_widget.dart';

class CurrentBookPage extends StatelessWidget {
  const CurrentBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController bookImageController = TextEditingController();
    final TextEditingController bookNameController = TextEditingController();
    final TextEditingController bookPageController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.sectionColor,
      appBar: CustomAppBar(
        title: 'Current Book',
        popAble: true,
        backgroundColor: AppColors.sectionColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            AdminFieldsWidget(
              controller: bookImageController,
              title: 'Book Image',
              hint: 'Image',
            ),
            AdminFieldsWidget(
              controller: bookNameController,
              title: 'Book Name',
              hint: 'Name of book',
            ),
            AdminFieldsWidget(
              controller: bookPageController,
              title: 'Book Pages',
              hint: 'Pages',
              keyboard: TextInputType.number,
            ),
            SizedBox(height: 20),
            CustomButton(
              onTap: () async {
                await FirebaseFirestore.instance
                    .collection('current')
                    .doc('current_book')
                    .delete();

                await FirebaseFirestore.instance
                    .collection('current')
                    .doc('current_book')
                    .set({
                  'bookName': bookNameController.text,
                  'image': bookImageController.text,
                  'page': int.tryParse(bookPageController.text) ?? 0,
                });

                // Show a confirmation message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Book published successfully')),
                );

                Navigator.pop(context);
              },
              btnText: 'Publish',
            ),
            SizedBox(height: 50),
            BlocProvider(
              create: (context) => CurrentBloc()..add(LoadCurrentEvent()),
              child: BlocBuilder<CurrentBloc, CurrentState>(
                builder: (context, state) {
                  if (state is LoadingCurrentState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.buttonColor,
                      ),
                    );
                  } else if (state is SuccessCurrentState) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 77,
                      child: ListView.builder(
                        itemCount: state.items.length,
                        itemBuilder: (context, index) {
                          return CurrentBookWidget(
                            bookName: state.items[index].bookName,
                            page: state.items[index].page,
                            image: state.items[index].image,
                          );
                        },
                      ),
                    );
                  } else {
                    return CustomButton(
                        onTap: () {
                          context.read<NewsBloc>().add(LoadNewsEvent());
                        },
                        btnText: 'Try again');
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
