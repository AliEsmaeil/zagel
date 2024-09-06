import 'package:chat/components/circular_indicator.dart';
import 'package:chat/components/gradientButton.dart';
import 'package:chat/components/sign_with_provider.dart';
import 'package:chat/components/text_field.dart';
import 'package:chat/components/toast.dart';
import 'package:chat/core/constants/gradient_color.dart';
import 'package:chat/models/user.dart';
import 'package:chat/modules/signin/signin_screen.dart';
import 'package:chat/modules/signup/cubit/cubit.dart';
import 'package:chat/modules/signup/cubit/states.dart';
import 'package:chat/utils/clippers/signin_clipper.dart';
import 'package:chat/utils/form_validator.dart';
import 'package:chat/utils/gradient_text.dart';
import 'package:chat/utils/social_icons.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  static const route = 'SIGNUP';

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          print('state is $state');
          if(state is SignUpCreatedUserState){
            showCustomToast(message: 'Successful Registration', status: ToastState.SUCESS);
            Future.delayed(Duration(seconds: 2),() => Navigator.pushNamed(context, SignInScreen.route,arguments: UserModel(
              email: emailController.text,
              password: passwordController.text,
            )),);

          }
          else if (state is SignUpCreatedUserErrorState){

            showCustomToast(message: state.message, status: ToastState.ERROR);
          }
        },
        builder: (context, state) {
          var cubit = SignUpCubit.getCubit(context);

          return Scaffold(
            body: SafeArea(
              child: Column(
                //mainAxisSize: MainAxisSize.max,
                children: [
                  ClipPath(
                    clipper: SignInClipper(),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height/5,
                      decoration: const BoxDecoration(
                        gradient: GRADIENT_COLOR,
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Sign up',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    letterSpacing: 1.2,
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GradientText(
                                'New Era of Social with Zagel',
                                gradient: GRADIENT_COLOR,
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              CustomTextField(
                                hintText: 'eg: Crystoph Waltz',
                                preIcon: Social.user,
                                inputType: TextInputType.name,
                                controller: nameController,
                                inputAction: TextInputAction.next,
                                validator: FormValidator.nameValidator,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                hintText: 'eg: 01283569512',
                                preIcon: Social.phone,
                                validator: FormValidator.phoneValidator,
                                inputType: TextInputType.phone,
                                controller: phoneController,
                                inputAction: TextInputAction.next,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                hintText: 'eg: CrystophWaltz@yahoo.com',
                                preIcon: Social.mail,
                                inputType: TextInputType.emailAddress,
                                controller: emailController,
                                inputAction: TextInputAction.next,
                                validator: FormValidator.emailValidator,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                hintText: '*********',
                                preIcon: Social.lock,
                                inputType: TextInputType.visiblePassword,
                                controller: passwordController,
                                inputAction: TextInputAction.go,
                                validator: FormValidator.passwordValidator,
                                isPassword: !cubit.visible,
                                sufIcon: cubit.visible
                                    ? Social.eye_slash
                                    : Social.eye_1,
                                onSubmit: (s){
                                  createUser(cubit);
                                },
                                onSufPressed: () {
                                  cubit.changePasswordVisibility();
                                },
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              ConditionalBuilder(
                                condition: state is! SignUpLoadingState,
                                builder: (context) => GradientButton(
                                  onTap: () {
                                    createUser(cubit);
                                  },
                                  gradient: GRADIENT_COLOR,
                                  text: 'Sign up',
                                ),
                                fallback: (context) =>
                                    const CustomCircularProgressIndicator(),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              const ProviderSignInList(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            resizeToAvoidBottomInset: false,
          );
        },
      ),
    );
  }

  void createUser(SignUpCubit cubit){

    if(formKey.currentState!.validate()){
      cubit.createUser(user: UserModel(
            name: nameController.text,
            email: emailController.text,
            phone: phoneController.text,
            password: passwordController.text,
          ));
    }
  }
}
