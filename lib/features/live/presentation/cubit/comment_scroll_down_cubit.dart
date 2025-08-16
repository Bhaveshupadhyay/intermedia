import 'package:flutter_bloc/flutter_bloc.dart';

class CommentScrollCubit extends Cubit<CommentScrollState>{
  CommentScrollCubit():super(CommentScrollStateInitial());

  void showScrollArrowDownIcon(){
    if(state is CommentScrollDownArrowHide || state is CommentScrollStateInitial){
      emit(CommentScrollDownArrowShow());
    }
  }
  void hideScrollArrowDownIcon(){
    if(state is CommentScrollDownArrowShow || state is CommentScrollStateInitial){
      emit(CommentScrollDownArrowHide());
    }
  }

}

sealed class CommentScrollState{}
class CommentScrollStateInitial extends CommentScrollState{}
class CommentScrollDownArrowShow extends CommentScrollState{}
class CommentScrollDownArrowHide extends CommentScrollState{}