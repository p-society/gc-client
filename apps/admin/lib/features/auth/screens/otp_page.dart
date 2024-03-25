import 'package:admin/constants/scaffold_messenger.dart';
import 'package:admin/features/auth/controller/auth_controller.dart';
import 'package:admin/features/auth/screens/login_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends ConsumerStatefulWidget {
  const OtpPage({super.key});

  @override
  ConsumerState<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  late TextEditingController otpController;
  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
  }

  void navController() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPageAdmin()));
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 47,
      height: 52,
      textStyle: const TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(17),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
          // color: Color.fromRGBO(234, 239, 243, 1),
          ),
    );

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            //aplying gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF111114),
              Color(0xFF161A3A),
              Color(0xFF171D45),
            ],
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 255,
              ),
              const Text(
                'Enter code send to your E-mail',
                style: TextStyle(
                  color: Color(0xFFE1DADE),
                  fontSize: 25,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'We have sent the code to abc@gmail.com',
                style: TextStyle(
                  color: Color(0xFFD3CFCF),
                  fontSize: 15,
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              const SizedBox(
                height: 43,
              ),
              Pinput(
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                controller: otpController,
                length: 6,
                onSubmitted: (s) async{
                  MyScaffoldMessage().showScaffoldMessenge(
                    context: context,
                    content: s,
                  );
                  ref
                      .watch(authControllerProvider)
                      .verifyOtp(s.toString())
                      .then((value) {
                    Navigator.of(context)
                        .push(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        )
                        .onError(
                          (error, _) =>
                              MyScaffoldMessage().showScaffoldMessenge(
                            context: context,
                            content: error.toString(),
                          ),
                        );
                  });
                },
                closeKeyboardWhenCompleted: true,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) => navController,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Didn\'t recieve the code?  ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Resend',
                      style: TextStyle(
                        color: Color(0xFFC01A60),
                        fontSize: 15,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Welcome to Home'),
      ),
    );
  }
}
