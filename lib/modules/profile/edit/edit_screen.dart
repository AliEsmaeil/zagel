import 'package:chat/components/ImagePickIconButton.dart';
import 'package:chat/components/circular_indicator.dart';
import 'package:chat/components/text_field.dart';
import 'package:chat/models/user.dart';
import 'package:chat/modules/profile/edit/cubit/cubit.dart';
import 'package:chat/modules/profile/edit/cubit/states.dart';
import 'package:chat/modules/profile/profile_screen.dart';
import 'package:chat/utils/current_user_getter/current_user_getter.dart';
import 'package:chat/utils/form_validator.dart';
import 'package:chat/utils/social_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {
  static const route = 'EDIT_PROFILE';
  final UserModel user = CurrentUser.user;

  final nameController = TextEditingController();
  final  bioController = TextEditingController();
  final phoneController = TextEditingController();


  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    nameController.text = user.name!;
    bioController.text = user.bio ?? '';
    phoneController.text = user.phone!;

    return BlocProvider(
        create: (context) => EditProfileScreenCubit(),
        child: BlocConsumer<EditProfileScreenCubit, EditProfileScreenStates>(
          listener: (context, state) {
            if (state is SuccessfulUserUpdateState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Successful Update'),
                backgroundColor: Colors.green,
              ));
              Future.delayed(
                  Duration(
                    seconds: 2,
                  ),
                  () => Navigator.of(context).pushNamed(ProfileScreen.route));
            } else if (state is UserUpdateErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Successful Update'),
                backgroundColor: Colors.red,
              ));
            }
          },
          builder: (context, state) {
            var cubit = EditProfileScreenCubit.getCubit(context);

            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 275,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: (cubit.cover == null)
                                      ? user.cover == null?
                                      NetworkImage('https://st4.depositphotos.com/4329009/19956/v/1600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg'):
                                      NetworkImage(user.cover!)
                                      : FileImage(cubit.cover!)
                                          as ImageProvider,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Wrap(
                                  children: [
                                    ImagePickIconButton(
                                      icon: Icons.browse_gallery,
                                      onPressed: () {
                                        cubit.getUserCover(ImageSource.gallery);
                                      },
                                    ),
                                    ImagePickIconButton(
                                      icon: Icons.camera_alt,
                                      onPressed: () {
                                        cubit.getUserCover(ImageSource.camera);
                                      },
                                    ),
                                  ],
                                  spacing: 10,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                //  color: Colors.green,
                                width: 200,
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      radius: 78,
                                      child: CircleAvatar(
                                        radius: 75,
                                        backgroundImage: (cubit.image == null)
                                            ? user.image == null?
                                        NetworkImage('https://st4.depositphotos.com/4329009/19956/v/1600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg'):
                                        NetworkImage(user.image!)
                                            : FileImage(cubit.image!)
                                                as ImageProvider,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 50,
                                      child: ImagePickIconButton(
                                        icon: Icons.camera_alt,
                                        onPressed: () {
                                          cubit
                                              .getUserImage(ImageSource.camera);
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      top: 50,
                                      left: 0,
                                      child: ImagePickIconButton(
                                        icon: Icons.browse_gallery,
                                        onPressed: () {
                                          cubit.getUserImage(
                                              ImageSource.gallery);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              controller: nameController,
                              inputType: TextInputType.name,
                              hintText: 'Your Name',
                              preIcon: Social.user,
                              inputAction: TextInputAction.next,
                              validator: FormValidator.nameValidator,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              controller: phoneController,
                              inputType: TextInputType.phone,
                              hintText: 'Your Phone',
                              preIcon: Social.phone,
                              inputAction: TextInputAction.next,
                              validator: FormValidator.phoneValidator,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              controller: bioController,
                              inputType: TextInputType.multiline,
                              hintText: 'Your Bio',
                              inputAction: TextInputAction.newline,
                              preIcon: Social.cc,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                cubit.updateUser(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text,
                                );
                              },
                              child: state is! UserUpdateLoadingState
                                  ? Text('Update')
                                  : CustomCircularProgressIndicator(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
