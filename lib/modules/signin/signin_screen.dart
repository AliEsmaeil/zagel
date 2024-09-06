import 'package:chat/components/circular_indicator.dart';
import 'package:chat/components/gradientButton.dart';
import 'package:chat/components/sign_with_provider.dart';
import 'package:chat/components/text_field.dart';
import 'package:chat/components/toast.dart';
import 'package:chat/core/constants/gradient_color.dart';
import 'package:chat/models/user.dart';
import 'package:chat/modules/home/home_screen.dart';
import 'package:chat/modules/signin/cubit/cubit.dart';
import 'package:chat/modules/signin/cubit/states.dart';
import 'package:chat/modules/signup/signup_screen.dart';
import 'package:chat/utils/clippers/signin_clipper.dart';
import 'package:chat/utils/form_validator.dart';
import 'package:chat/utils/gradient_text.dart';
import 'package:chat/utils/social_icons.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  static const route = 'SIGNIN';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user;
    if ((ModalRoute.of(context)?.settings.arguments != null)) {
      user = ModalRoute.of(context)?.settings.arguments as UserModel;
      emailController.text = user.email;
      passwordController.text = user.password;
    }
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInStates>(
        listener: (context, state) {
          if (state is SignInSuccessLoginState) {
            Navigator.of(context).pushNamed(HomeScreen.route);
          } else if (state is SignInLoginErrorState) {
            showCustomToast(message: state.message, status: ToastState.ERROR);
          }
        },
        builder: (context, state) {
          var cubit = SignInCubit.getCubit(context);

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  ClipPath(
                    clipper: SignInClipper(),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 5,
                      decoration: BoxDecoration(
                        gradient: GRADIENT_COLOR,
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Sign in',
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
                        padding: const EdgeInsets.all(10),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const GradientText(
                                'New Era of Social with Zagel',
                                gradient: GRADIENT_COLOR,
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              CustomTextField(
                                hintText: 'Email',
                                preIcon: Social.mail,
                                validator: FormValidator.emailValidator,
                                inputType: TextInputType.emailAddress,
                                controller: emailController,
                                inputAction: TextInputAction.next,
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              CustomTextField(
                                hintText: 'Password',
                                preIcon: Social.lock,
                                validator: FormValidator.passwordValidator,
                                inputType: TextInputType.visiblePassword,
                                controller: passwordController,
                                inputAction: TextInputAction.go,
                                isPassword: !cubit.visible,
                                sufIcon: cubit.visible
                                    ? Social.eye_slash
                                    : Social.eye_1,
                                onSufPressed: () {
                                  cubit.changePasswordVisibility();
                                },
                                onSubmit: (s) {
                                  signIn(cubit);
                                },
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              ConditionalBuilder(
                                condition: state is! SignInLoadingState,
                                builder: (context) => GradientButton(
                                  onTap: () {
                                    signIn(cubit);
                                  },
                                  gradient: GRADIENT_COLOR,
                                  text: 'Sign in',
                                ),
                                fallback: (context) =>
                                    CustomCircularProgressIndicator(),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Become a member',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w300,
                                        ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(SignUpScreen.route);
                                    },
                                    child: Text('Register',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Colors.blue.shade700,
                                            )),
                                  )
                                ],
                              ),
                              // Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const ProviderSignInList(),
                ],
              ),
            ),
            resizeToAvoidBottomInset: false,
          );
        },
      ),
    );
  }

  void signIn(SignInCubit cubit) {
    if (formKey.currentState!.validate()) {
      cubit.signIn(
          user: UserModel(
              email: emailController.text, password: passwordController.text));
    }
  }
}
