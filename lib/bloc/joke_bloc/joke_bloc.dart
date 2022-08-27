import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jokes_project/bloc/joke_bloc/joke_event.dart';
import 'package:jokes_project/bloc/joke_bloc/joke_state.dart';
import 'package:jokes_project/data/repositories/joke_repository.dart';

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  final JokeRepository _jokeRepository;

  JokeBloc(this._jokeRepository) : super(JokeLoadingState()) {
    on<JokeEvent>((event, emit) async {
      emit(JokeLoadingState());
      try {
        final joke = await _jokeRepository.getJoke();
        emit(JokeLoadedState(joke));
      } catch (e) {
        emit(JokeErrorState(e.toString()));
      }
    });
  }
}
