import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String username = '', password = '', email = '', userName = '';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Stack(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/movie_collage_dark.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 100.0),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: SvgPicture.asset(
                        'assets/logos/cinema_star.svg',
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const Text(
                      'MOVIE RANK',
                      style: TextStyle(
                          fontFamily: 'Titilium',
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Container(
                      width: 255,
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'NotoSans',
                        ),
                        autofillHints: const [AutofillHints.email],
                        cursorColor: Colors.orange[500],
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10.0),
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: SvgPicture.asset('assets/logos/mail.svg',
                                  fit: BoxFit.scaleDown),
                            ),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          hintText: 'Correo',
                          contentPadding: const EdgeInsets.only(right: 10.0),
                          isDense: true,
                          hintStyle: const TextStyle(fontSize: 14.0),
                        ),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 255,
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: TextFormField(
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'NotoSans',
                        ),
                        onFieldSubmitted: (value) async {},
                        obscureText: true,
                        cursorColor: Colors.orange[500],
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10.0),
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: SvgPicture.asset('assets/logos/lock.svg',
                                  fit: BoxFit.scaleDown),
                            ),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          hintText: 'Contrase??a',
                          contentPadding: const EdgeInsets.only(right: 10.0),
                          isDense: true,
                          hintStyle: const TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'NotoSans',
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: TextButton(
                            onPressed: () {
                              signIn();
                            },
                            style: TextButton.styleFrom(
                              fixedSize: const Size(120, 40),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              backgroundColor: Colors.orange[700],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              elevation: 10,
                            ),
                            child: const Text(
                              'INGRESAR',
                              style: TextStyle(
                                fontFamily: 'Titilium',
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: TextButton(
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) => createUserName());
                            },
                            style: TextButton.styleFrom(
                              fixedSize: const Size(120, 40),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              backgroundColor: Colors.orange[500],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              elevation: 10,
                            ),
                            child: const Text(
                              'REGISTRO',
                              style: TextStyle(
                                fontFamily: 'Titilium',
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 40.0),
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                            Colors.amberAccent, BlendMode.modulate),
                        child: Image.asset('assets/images/stars.png'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  createUserName() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    return AlertDialog(
      title: const Center(child: Text('Crear Usuario')),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
      buttonPadding: const EdgeInsets.only(top: 0.0),
      actionsPadding: const EdgeInsets.only(bottom: 10.0),
      content: Form(
        child: SizedBox(
          height: 45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                onFieldSubmitted: (value) async {},
                cursorColor: Colors.orange[500],
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'nombre de usuario',
                  contentPadding: const EdgeInsets.all(10.0),
                  isDense: true,
                  hintStyle: const TextStyle(fontSize: 14),
                ),
                onChanged: (value) {
                  setState(() {
                    userName = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            fixedSize: const Size(50, 40),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            backgroundColor: Colors.orange[500],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            elevation: 10,
          ),
          onPressed: () {
            signUp(userName);
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text(
            'Crear',
            style: TextStyle(
              fontFamily: 'Titilium',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
            ),
          ),
        )
      ],
    );
  }

  Future signIn() async {
    await EasyLoading.show(status: 'Iniciando sesi??n ...');
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      EasyLoading.showSuccess('Bienvenido!',
          duration: const Duration(seconds: 1));
    } on FirebaseAuthException catch (e) {
      EasyLoading.showError(e.message.toString());
    }
  }

  Future signUp(String userName) async {
    if (userName == '') {
      return;
    }
    await EasyLoading.show(status: 'Creando usuario ...');
    final DatabaseReference ref = FirebaseDatabase.instance.ref('usuarios');
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((res) async {
        await res.user!.updateDisplayName(userName);
        await res.user!.reload();
      });
      await ref
          .child(FirebaseAuth.instance.currentUser!.uid)
          .set({'nombre': userName});
      EasyLoading.showSuccess('Usuario creado con ??xito!');
    } on FirebaseAuthException catch (e) {
      EasyLoading.showError(e.message.toString());
    }
  }
}
