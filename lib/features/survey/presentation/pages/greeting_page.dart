import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/features/survey/presentation/bloc/survey_bloc.dart';
import 'package:survey_app/features/survey/presentation/fixed_values/survey_sizes.dart';

import '../fixed_values/survey_paths.dart';
import '../widgets/next_button.dart';

class GreetingPage extends StatelessWidget {
  final surveyTitle = 'Fragebogen zur Videoaufklärung';
  final introductionText =
      'Liebe Patientin, lieber Patient,\n\nbitte nutzen Sie Gelegenheit, um uns mit dem folgenden Fragebogen Ihre Eindrücke mitzuteilen. \n\nIhre Antworten werden streng anonym gespeichert und ausgewertet und haben keinerlei Auswirkungen auf Ihre individuelle medizinische Behandlung.\n\nVielen Dank im Voraus! \n\nIhr Ärzte-Team';
  final startSurveyButtonText = 'Start';

  const GreetingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
          SurveySizes.scaledWidth(SurveySizes.paddingSize, context)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            ImagePaths.healthProfessionals,
            width: SurveySizes.scaledWidth(SurveySizes.imageWidth, context),
          ),
          SizedBox(
            height:
                SurveySizes.scaledHeight(SurveySizes.standardDistance, context),
          ),
          Text(
            surveyTitle,
            style: Theme.of(context).textTheme.headline4.copyWith(
                fontSize: SurveySizes.scaledWidth(
                    SurveySizes.questionFontSize, context)),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height:
                SurveySizes.scaledHeight(SurveySizes.standardDistance, context),
          ),
          Text(
            introductionText,
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: SurveySizes.scaledHeight(
                      SurveySizes.regularFontSize, context),
                ),
          ),
          SizedBox(
            height: SurveySizes.smallDistance,
          ),
          NextButton(
            activated: true,
            onPressed: () {
              BlocProvider.of<SurveyBloc>(context).add(StartSurveyEvent());
            },
            text: startSurveyButtonText,
          ),
        ],
      ),
    );
  }
}
