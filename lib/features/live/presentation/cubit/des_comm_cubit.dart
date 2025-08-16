import 'package:flutter_bloc/flutter_bloc.dart';

class DesCommCubit extends Cubit<DesCommState>{

  DesCommCubit(): super(DesInitial());

  void showDescription(){
    emit(DescriptionShow());
  }

  void hideDescription(){
    emit(DescriptionHide());
  }

  void showComment(){
    emit(CommentShow());
  }

  void hideComment(){
    emit(CommentHide());
  }

  Future<void> getPostDetails(String postId) async {
    // emit(DescriptionLoading());
    // PostModal postModal = await MyApi.getInstance.getPostById(postId);
    // if(!isClosed) {
    //   emit(DescriptionLoaded(postModal));
    // }
  }
}

sealed class DesCommState{}
class DesInitial extends DesCommState{}

class DescriptionLoading extends DesCommState{}
class DescriptionShow extends DesCommState{}
class DescriptionHide extends DesCommState{}
class CommentShow extends DesCommState{}
class CommentHide extends DesCommState{}
class DescriptionLoaded extends DesCommState{

}