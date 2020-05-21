import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/survey_element.dart';
import '../../domain/usecases/start_survey_usecase.dart';
import '../../domain/usecases/submit_survey_usecase.dart';

part 'survey_event.dart';
part 'survey_state.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  int _currentQuestion;
  //List<Question> questions;
  List<QuestionState> questionStates;

  final StartSurveyUseCase startSurveyUseCase;
  final SubmitSurveyUseCase submitSurveyUseCase;

  SurveyBloc({
    @required this.startSurveyUseCase,
    @required this.submitSurveyUseCase,
  });

  @override
  SurveyState get initialState => GreetingState();

  @override
  Stream<SurveyState> mapEventToState(
    SurveyEvent event,
  ) async* {
    if (event is StartSurveyEvent) {
      yield LoadingState();
      Either<Failure, List<SurveyElement>> result =
          await startSurveyUseCase(NoParams);
      yield result.fold(
        (failure) => FailureState(),
        (surveyElements) {
          _currentQuestion = 0;
          questionStates = surveyElements.map((e) => QuestionState(e)).toList();
          return questionStates[_currentQuestion];
        },
      );
    } else if (event is NextQuestionEvent) {
      if (_currentQuestion == null || questionStates == null) {
        yield FailureState();
      } else {
        _currentQuestion++;
        yield questionStates[_currentQuestion];
      }
    } else if (event is SubmitAnswersEvent) {
      yield LoadingState();
      submitSurveyUseCase(questionStates.map((e) => e.surveyElement).toList());
      yield ThankYouState();
    }
  }
}