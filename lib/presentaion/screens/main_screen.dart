import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/business/firebase_auth_cubit/firebase_auth_cubit.dart';
import 'package:note_app/config/app_routes/app_routes.dart';
import 'package:note_app/core/utils/app_colors.dart';
import 'package:note_app/core/utils/app_strings.dart';
import 'package:note_app/core/utils/media_query.dart';
import 'package:note_app/presentaion/screens/edit_note_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((value) {
      print('====================================');
      print(value);
      print('====================================');
    });

    print('====================================');
    FirebaseMessaging.onMessage.listen((event) {
      print('====================================');
      print('${event.notification!.title}');
      print('====================================');
      AwesomeDialog(
              context: context,
              title: '${event.notification!.title}',
              body: Text('${event.notification!.body}'))
          .show();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.welcomeTitle),
        actions: [
          BlocListener<FirebaseCubit, FirebaseState>(
            listener: (context, state) {
              if (state is FirebaseSingOutSuccessState) {
                Navigator.pushReplacementNamed(context, Routers.loginScreen);
              }
            },
            child: IconButton(
              onPressed: () {
                BlocProvider.of<FirebaseCubit>(context).signOut();
              },
              color: Theme.of(context).primaryColor,
              icon: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: BlocBuilder<FirebaseCubit, FirebaseState>(
            builder: (context, state) {
          final notes = BlocProvider.of<FirebaseCubit>(context).notes;
          final notesId = BlocProvider.of<FirebaseCubit>(context).notesId;
          if (state is FirebaseGetNotesSuccessState) {
            if (notes.isNotEmpty) {
              return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute<EditNoteScreen>(
                              builder: (_) => BlocProvider.value(
                                  value:
                                      BlocProvider.of<FirebaseCubit>(context),
                                  child: EditNoteScreen(
                                    docId: notesId[index],
                                    note: notes[index],
                                  )),
                            ));
                          },
                          child: Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              BlocProvider.of<FirebaseCubit>(context)
                                  .deleteNotes(docId: notesId[index]);
                            },
                            child: ListTile(
                              title: Text(
                                notes[index].title,
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              subtitle: Text(notes[index].body,
                                  style: Theme.of(context).textTheme.bodyText2),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: notes.length);
            } else {
              return const Center(
                child: Text('No Data To Show'),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routers.addNoteScreen);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
