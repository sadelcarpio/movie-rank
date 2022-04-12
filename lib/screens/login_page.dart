import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_ratings/services/api_calls.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String username, password, email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/movie_collage.webp',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: const Color(0xFFFF9F1C),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: const Color(0xFFFFBF69),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/logos/cinema_star.svg'),
                          Stack(
                            children: [
                              const Text(
                                'MOVIE RANK',
                                style: TextStyle(
                                    fontFamily: 'Titilium',
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                'MOVIE RANK',
                                style: TextStyle(
                                  fontFamily: 'Titilium',
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1.5
                                    ..color = Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 250,
                            child: TextFormField(
                              autofillHints: const [AutofillHints.email],
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: SvgPicture.asset(
                                          'assets/logos/mail.svg',
                                          fit: BoxFit.scaleDown),
                                    ),
                                  ),
                                  prefixIconConstraints: const BoxConstraints(
                                    minWidth: 20,
                                    minHeight: 20,
                                  ),
                                  hintText: 'Correo',
                                  contentPadding: const EdgeInsets.all(12.0),
                                  isDense: true,
                                  hintStyle: const TextStyle(fontSize: 14)),
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 250,
                            child: TextFormField(
                              onFieldSubmitted: (value) async {
                                if (MediaQuery.of(context).size.width >= 900) {
                                  await HttpService.login(
                                      email, password, context);
                                }
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: SvgPicture.asset(
                                          'assets/logos/lock.svg',
                                          fit: BoxFit.scaleDown),
                                    ),
                                  ),
                                  prefixIconConstraints: const BoxConstraints(
                                    minWidth: 20,
                                    minHeight: 20,
                                  ),
                                  hintText: 'Contraseña',
                                  contentPadding: const EdgeInsets.all(12.0),
                                  isDense: true,
                                  hintStyle: const TextStyle(fontSize: 14)),
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                await HttpService.login(
                                    email, password, context);
                              },
                              style: TextButton.styleFrom(
                                fixedSize: const Size(250, 50),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                backgroundColor: const Color(0xFFFF9F1C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 10,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
                                child: Stack(
                                  children: [
                                    const Text(
                                      'INGRESAR',
                                      style: TextStyle(
                                        fontFamily: 'Titilium',
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFFFFFF),
                                      ),
                                    ),
                                    Text(
                                      'INGRESAR',
                                      style: TextStyle(
                                        fontFamily: 'Titilium',
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth = 1.5
                                          ..color = Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                await showDialog(
                                  builder: (BuildContext context) {
                                    late String email, username, password;
                                    return AlertDialog(
                                        content: SizedBox(
                                      height: 320,
                                      width: 300,
                                      child: SingleChildScrollView(
                                        child: Column(children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 15.0),
                                            child: Text(
                                              'Registro',
                                              style: TextStyle(
                                                fontFamily: 'Titilium',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24.0,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                prefixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child: SvgPicture.asset(
                                                        'assets/logos/mail.svg',
                                                        fit: BoxFit.scaleDown),
                                                  ),
                                                ),
                                                prefixIconConstraints:
                                                    const BoxConstraints(
                                                  minWidth: 20,
                                                  minHeight: 20,
                                                ),
                                                hintText: 'Correo',
                                                contentPadding:
                                                    const EdgeInsets.all(10.0),
                                                isDense: true,
                                                hintStyle: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                              onChanged: (value) => {
                                                setState(() {
                                                  email = value;
                                                })
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                prefixIcon: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child: SvgPicture.asset(
                                                        'assets/logos/user.svg',
                                                        fit: BoxFit.scaleDown),
                                                  ),
                                                ),
                                                prefixIconConstraints:
                                                    const BoxConstraints(
                                                  minWidth: 20,
                                                  minHeight: 20,
                                                ),
                                                hintText: 'Nombre de usuario',
                                                contentPadding:
                                                    const EdgeInsets.all(10.0),
                                                isDense: true,
                                                hintStyle: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                              onChanged: (value) => {
                                                setState(() {
                                                  username = value;
                                                })
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: TextFormField(
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                prefixIcon: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child: SvgPicture.asset(
                                                        'assets/logos/lock.svg',
                                                        fit: BoxFit.scaleDown),
                                                  ),
                                                ),
                                                prefixIconConstraints:
                                                    const BoxConstraints(
                                                  minWidth: 20,
                                                  minHeight: 20,
                                                ),
                                                hintText: 'Contraseña',
                                                contentPadding:
                                                    const EdgeInsets.all(10.0),
                                                isDense: true,
                                                hintStyle: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                              onFieldSubmitted: (value) async {
                                                if (MediaQuery.of(context)
                                                        .size
                                                        .width >=
                                                    900) {
                                                  await HttpService.register(
                                                      email,
                                                      username,
                                                      password,
                                                      context);
                                                }

                                                if (!mounted) return;
                                                Navigator.of(context).pop();
                                                setState(() {});
                                              },
                                              onChanged: (value) => {
                                                setState(() {
                                                  password = value;
                                                })
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: TextButton(
                                              onPressed: () async {
                                                await HttpService.register(
                                                    email,
                                                    username,
                                                    password,
                                                    context);
                                                if (!mounted) return;
                                                Navigator.of(context).pop();
                                                setState(() {});
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  color:
                                                      const Color(0xFFFF9F1C),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 30.0,
                                                      vertical: 0.0),
                                                  child: Text(
                                                    'LISTO',
                                                    style: TextStyle(
                                                        fontFamily: 'Titilium',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 24.0,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ]),
                                      ),
                                    ));
                                  },
                                  context: context,
                                );
                              },
                              style: TextButton.styleFrom(
                                fixedSize: const Size(250, 50),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 5),
                                backgroundColor: const Color(0xFFFF9F1C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 10,
                              ),
                              child: Stack(
                                children: [
                                  const Text(
                                    'REGISTRARSE',
                                    style: TextStyle(
                                      fontFamily: 'Titilium',
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFFFFFF),
                                    ),
                                  ),
                                  Text(
                                    'REGISTRARSE',
                                    style: TextStyle(
                                      fontFamily: 'Titilium',
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 1.5
                                        ..color = Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                ),
              ),
            )
          ]),
        ));
  }
}
