import 'package:customer_fyp/bloc/page_status/page_status_bloc.dart';
import 'package:customer_fyp/helper/responsive_sizer/responsive_sizer.dart';
import 'package:customer_fyp/styles/input_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/api/api_bloc.dart';
import '../../bloc/api/api_event.dart';
import '../../components/basic_card.dart';
import '../../helper/screen_mapper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            const Text(
              "Customer",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 32,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<PageStatusBloc>(context).add(
                      const PageStatusEvent(PageStatus.registerScreen),
                    );
                  },
                  child: const Text("Register"),
                ),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<ApiBloc>(context).add(
                      ApiLoginEvent(
                        emailController.text,
                        passwordController.text,
                      ),
                    );
                  },
                  child: const Text("Login"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
