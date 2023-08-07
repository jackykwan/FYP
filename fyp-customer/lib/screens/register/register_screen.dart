import 'package:customer_fyp/bloc/api/api_bloc.dart';
import 'package:customer_fyp/bloc/api/api_event.dart';
import 'package:customer_fyp/helper/responsive_sizer/responsive_sizer.dart';
import 'package:customer_fyp/styles/input_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/page_status/page_status_bloc.dart';
import '../../components/basic_card.dart';
import '../../helper/screen_mapper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 24.responsiveW,
        vertical: 150.responsiveH,
      ),
      child: BasicCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: basicInputDecoration.copyWith(hintText: "Email"),
              controller: emailController,
            ),
            SizedBox(
              height: 16.responsiveH,
            ),
            TextFormField(
              decoration: basicInputDecoration.copyWith(hintText: "Password"),
              controller: passwordController,
              obscureText: true,
            ),
            SizedBox(
              height: 16.responsiveH,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<PageStatusBloc>(context).add(
                      const PageStatusEvent(PageStatus.loginScreen),
                    );
                    BlocProvider.of<ApiBloc>(context).add(
                      ApiRegisterEvent(
                        emailController.text,
                        passwordController.text,
                      ),
                    );
                  },
                  child: const Text("Register"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
