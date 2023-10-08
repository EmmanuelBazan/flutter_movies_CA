import 'package:flutter/material.dart';
import 'package:flutter_movies_ca/app/domain/enums.dart';
import 'package:flutter_movies_ca/app/presentation/global/controllers/session_controller.dart';
import 'package:flutter_movies_ca/app/presentation/routes/routes.dart';
import 'package:flutter_movies_ca/app/presentation/screens/signIn/controller/sign_in_controller.dart';
import 'package:provider/provider.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SignInController>(context);

    return MaterialButton(
      onPressed: () {
        final isValid = Form.of(context)!.validate();
        if (isValid) {
          _submit(context);
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.lightBlue[900],
          borderRadius: BorderRadius.circular(10),
        ),
        child: controller.state.loading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Text(
                'Sign In',
                style: TextStyle(color: Colors.white),
              ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    final SignInController controller = context.read();

    final res = await controller.submit();

    if (!controller.mounted) {
      return;
    }

    res.when((failure) {
      final message = {
        SignInFailure.notFound: 'Invalid user',
        SignInFailure.unauthorized: 'Invalid password',
        SignInFailure.unknown: 'Error',
        SignInFailure.network: 'Network error',
      }[failure];

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message!),
      ));
    }, (user) {
      final SessionController sessionController = context.read();
      sessionController.setUser(user);
      Navigator.pushReplacementNamed(context, Routes.homeScreen);
    });
  }
}
