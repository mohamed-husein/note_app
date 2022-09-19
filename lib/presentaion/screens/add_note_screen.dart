import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_app/business/firebase_auth_cubit/firebase_auth_cubit.dart';
import 'package:note_app/config/app_routes/app_routes.dart';
import 'package:note_app/core/utils/app_colors.dart';
import 'package:note_app/core/utils/media_query.dart';
import 'package:note_app/presentaion/widgets/text_form_widget.dart';

class AddNoteScreen extends StatelessWidget {
  AddNoteScreen({Key? key}) : super(key: key);
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Notes'),
        actions: [
          BlocBuilder<FirebaseCubit, FirebaseState>(
            builder: (context, state) => IconButton(
                onPressed: () {
                  BlocProvider.of<FirebaseCubit>(context).uploadNoteImage();
                },
                icon: SvgPicture.asset('assets/icons/gallery.svg')),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormFieldWidget(
              controller: titleController,
              hintText: 'Title',
              onSaved: (newValue) {
                
              },
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  "assets/icons/text.svg",
                ),
              ),
              isSuffix: false,
              obscureText: false,
              suffixIcon: Container(),
              validator: (value) {
                return null;
              },
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    height: MediaQuery.of(context).size.height - 325,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.whiteColor,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 20),
                            child: TextFormField(
                              controller: bodyController,
                              maxLines: 20,
                              autofocus: false,
                              style: const TextStyle(fontSize: 20),
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                hintText: 'Body',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                BlocBuilder<FirebaseCubit, FirebaseState>(
                    builder: (context, state) {
                  if (state is FirebasPickNoteImageSuccessState) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.file(
                            state.image,
                            height: 250,
                            width: context.width - 40,
                          ),
                          InkWell(
                            onTap: () {
                              BlocProvider.of<FirebaseCubit>(context)
                                  .clearImage();
                            },
                            child: CircleAvatar(
                              backgroundColor: AppColors.greyColor,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  "assets/icons/cross.svg",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                })
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: MaterialButton(
                color: AppColors.mainColor,
                height: 60,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  BlocProvider.of<FirebaseCubit>(context).addNotes(
                      title: titleController.text, body: bodyController.text);
                  Navigator.pushNamed(context, Routers.mainScreen);
              
                },
                child: SizedBox(
                  width: context.width,
                  child: Center(
                    child: Text(
                      'Add Note',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
