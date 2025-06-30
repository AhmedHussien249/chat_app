import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    // bt3ml a el trasition bt3rfny el state el ana wa2f feha w el event el d5ly b3d kda el state el tl3t
    // This method is called whenever a transition occurs in the bloc.
    // You can use it to log transitions or perform other actions.
    // For example, you can log the transition:
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    // This method is called whenever the state changes.
    // You can use it to log state changes or perform other actions.
    // For example, you can log the state change:
    super.onChange(bloc, change);
    print(change);
  }
}
