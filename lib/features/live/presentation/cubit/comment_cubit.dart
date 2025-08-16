import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shawn/core/service/network_api.dart';

import '../../../../core/common/model/comment_model.dart';

class CommentCubit extends Cubit<FetchCommentState>{

  bool _hasReachedMax=false;
  bool _isLoading=false;
  final List<CommentModel> sampleList=[];
  int x=1;
  Timer? timer;
  CommentCubit():super(CommentInitial());

  Future<void> fetchComments() async {
    sampleList.add(CommentModel(commentId: x, userId: x, name: 'daru $x',comment: 'Hii', usaTimestamp: 1707043200, date: '2025-07-21T14:30:00'));

    for(int i=0; i<20;i++){
      x++;
      sampleList.add(CommentModel(commentId: x, userId: x, name: 'daru $x',comment: 'Hii', usaTimestamp: 1707043200, date: '2025-07-21T14:30:00'));
    }
    // timer= Timer.periodic(Duration(seconds: 3), (t){
    //   x++;
    //   sampleList.add(CommentModel(commentId: x, userId: x, name: 'daru $x',comment: 'Hii', usaTimestamp: 1707043200, date: '2025-07-21T14:30:00'));
    //   emit(CommentLoaded(list: sampleList, hasReachedMax: false));
    //   t.cancel();
    // },
    // );
    // if(x==10) timer?.cancel();

    emit(CommentLoaded(list: sampleList, hasReachedMax: false));
  }


  Future<void> insertComments(String text)async {
    // if(UserDetails.id==null || UserDetails.id==''){
    //   emit(NotLoggedIn());
    //   return;
    // }
    // if(text.trim().isEmpty){
    //   // emit(CommentInsertFailed('Comment can be empty'));
    //   return;
    // }
    // List<CommentModel> oldList= (state is CommentLoaded)? (state as CommentLoaded).list : [];
    // CommentModel CommentModel=await MyApi.getInstance.insertComment(UserDetails.id!, postId, text);
    // emit(CommentInsertLoading());
    // oldList.insert(0, CommentModel);
    // // print(oldList.length);
    // emit(CommentLoaded(oldList,_hasReachedMax));
  }

  @override
  Future<void> close() {
    if(timer!=null){
      timer!.cancel();
    }
    return super.close();
  }
}

abstract class FetchCommentState{}
class CommentInitial extends FetchCommentState{}
class CommentLoading extends FetchCommentState{}

class CommentLoaded extends FetchCommentState{
  final List<CommentModel> list;
  final bool hasReachedMax;

  CommentLoaded({required this.list, required this.hasReachedMax});

  CommentLoaded copyWith({
    List<CommentModel>? list,
    bool? hasReachedMax,
  })=>
      CommentLoaded(
          list: list?? this.list,
          hasReachedMax: hasReachedMax?? this.hasReachedMax,
      );
}

class CommentInsertLoading extends FetchCommentState{}

class CommentInsertFailed extends FetchCommentState{
  final String errorMsg;

  CommentInsertFailed(this.errorMsg);
}

class NotLoggedIn extends FetchCommentState{}

