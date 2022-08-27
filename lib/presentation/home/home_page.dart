import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/joke_bloc/joke_bloc.dart';
import '../../bloc/joke_bloc/joke_event.dart';
import '../../bloc/joke_bloc/joke_state.dart';
import '../../data/repositories/joke_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JokeBloc(
        RepositoryProvider.of<JokeRepository>(context),
      )..add(LoadJokeEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('The Joke App'),
        ),
        body: BlocBuilder<JokeBloc, JokeState>(
          builder: (context, state) {
            if (state is JokeLoadingState) {
              return _loadingWidget();
            }
            if (state is JokeLoadedState) {
              return _jokeWidget(context, state);
            }
            if (state is JokeErrorState) {
              return _errorWidget(state);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

Widget _loadingWidget() => const Center(
      child: CircularProgressIndicator(),
    );

Widget _jokeWidget(BuildContext context, JokeLoadedState state) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ExpansionTile(
            title: Text(
              state.joke.setup,
              textAlign: TextAlign.center,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  state.joke.delivery,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<JokeBloc>(context).add(LoadJokeEvent());
            },
            child: const Text('Load New Joke'),
          ),
        ],
      ),
    );

Widget _errorWidget(JokeErrorState state) => Center(
      child: Text(state.error.toString()),
    );
