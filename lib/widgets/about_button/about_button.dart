import 'package:flutter/material.dart';

import 'custom_rect_tween.dart';
import 'hero_dialog_route.dart';

/// {@template add_todo_button}
/// Button
///
/// Abre HeroDialogRoute de _AddAboutPopupCard
///
/// Uses a [Hero] with tag [_heroAbout].
/// {@endtemplate}
class AboutButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            return _AddAboutPopupCard();
          }));
        },
        child: Hero(
          tag: _heroAbout,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: Colors.transparent,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Icon(
              Icons.info_outline,
              size: MediaQuery.of(context).size.width <= 400 ? 30 : 45,
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}

const String _heroAbout = 'add-about-hero';

///
/// Pop up con la información de la página
///  Usa un widget [Hero] con el tag [_heroAbout] para conseguir
///  el efecto de desplegar
///

class _AddAboutPopupCard extends StatelessWidget {
  double getFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width <= 400 ? 15 : 20;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAbout,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: Colors.white70,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/UGR-Logo.png',
                      scale: 5,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        'Esta aplicación ha sido desarrollada para la asignatura '
                        '"Ingeniería de Sistemas de Información" impartida por la '
                        'universidad de Granada.\n ',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)),
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 5.0, left: 5.0),
                                  child: Text(
                                    "Grupo A2",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.0
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "Alejandro Molina Criado",
                                style: TextStyle(
                                    fontSize: getFontSize(context),
                                    color: Colors.black),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "Alejandro Soriano Morante",
                                style: TextStyle(
                                    fontSize: getFontSize(context),
                                    color: Colors.black),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "Antonio Carlos Martínez Garcia",
                                style: TextStyle(
                                    fontSize: getFontSize(context),
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
