import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_app/business/firebase_auth_cubit/firebase_auth_cubit.dart';
import 'package:note_app/config/app_routes/app_routes.dart';
import 'package:note_app/core/utils/app_colors.dart';
import 'package:note_app/core/utils/media_query.dart';
import 'package:note_app/data/model/note_model.dart';

class EditNoteScreen extends StatelessWidget {
  EditNoteScreen({
    Key? key,
    required this.note,
    required this.docId,
  }) : super(key: key);
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final NoteModel note;
  final String docId;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Notes'),
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
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, right: 20, left: 20, bottom: 12),
              child: TextFormField(
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                obscureText: false,
                controller: titleController,
                
                validator: (value) {
                  return null;
                },
                cursorColor: AppColors.mainColor,
                cursorHeight: 20,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: AppColors.whiteColor,
                  filled: true,
                  hintText: note.title,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 0),
                  hintStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SvgPicture.asset(
                      "assets/icons/text.svg",
                    ),
                  ),
                ),
              ),
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
                             
                              maxLines: 20,
                              controller: bodyController,
                              autofocus: false,
                              style: const TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                hintStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                hintText: note.body,
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
                  BlocProvider.of<FirebaseCubit>(context).updataNotes(
                      body: bodyController.text,
                      docId: docId,
                      
                      title: titleController.text);
                  Navigator.pushNamed(context, Routers.mainScreen);
                },
                child: SizedBox(
                  width: context.width,
                  child: Center(
                    child: Text(
                      'Edit Note',
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
