import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shawn/core/common/model/comment_model.dart';
import 'package:shawn/features/live/presentation/cubit/comment_scroll_down_cubit.dart';

import '../../../auth/presentation/screens/login.dart';
import '../cubit/comment_cubit.dart';
import 'comment_widget.dart';


class LiveCommentsDialog extends StatefulWidget {

  const LiveCommentsDialog({super.key,});

  @override
  State<LiveCommentsDialog> createState() => _LiveCommentsDialogState();
}

class _LiveCommentsDialogState extends State<LiveCommentsDialog> {
  final TextEditingController _commentController=TextEditingController();
  final _scrollController= ScrollController();


  @override
  void initState() {
    _setScrollListener();
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 20.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Comments',
                style: theme.textTheme.titleMedium
              ),
              InkWell(
                  onTap: ()=>Navigator.pop(context),
                  child: Icon(Icons.close_sharp,size: 30.r,))
            ],
          ),
          SizedBox(height: 5.h,),
          const Divider(),
          SizedBox(height: 5.h,),
          Expanded(
            child: BlocConsumer<CommentCubit,FetchCommentState>(
              builder: (BuildContext context, FetchCommentState state) {
                if(state is CommentLoading){
                  return const Center(child: CircularProgressIndicator());
                }
                else if(state is CommentLoaded){
                  // List<CommentModal> list=state as
                  // print('$state ${state.list.length}');
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(state.list.isNotEmpty)
                        Expanded(
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (scrollInfo) {
                              if (!state.hasReachedMax &&
                                  scrollInfo.metrics.pixels ==
                                      scrollInfo.metrics.maxScrollExtent) {
                                // context.read<CommentCubit>().fetchComments();
                              }
                              return true;
                            },
                            child: Stack(
                              children: [
                                ListView.separated(
                                  controller: _scrollController,
                                    // itemCount: state.list.length+(state.hasReachedMax?0:1),
                                    itemCount: state.list.length,
                                    itemBuilder: (context,index){
                                      if(index<state.list.length){
                                        CommentModel commentModal= state.list[index];
                                        return Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                                          child: CommentWidget(commentModal: commentModal,isReplyScreen: false,),
                                        );
                                      }
                                      else{
                                        return Column(
                                          children: [
                                            SizedBox(height: 5.h,),
                                            const CircularProgressIndicator(),
                                            SizedBox(height: 5.h,),
                                          ],
                                        );
                                      }
                                    },
                                    separatorBuilder: (BuildContext context, int index){
                                      return SizedBox(height: 20.h,);
                                    }
                                ),
                                BlocBuilder<CommentScrollCubit,CommentScrollState>(
                                  builder: (context,state){
                                    if(state is CommentScrollDownArrowShow){
                                      return Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: IconButton(
                                            onPressed: (){
                                              _scrollToLastItem();
                                            },
                                            icon: Icon(Icons.arrow_downward,size: 15.sp,),
                                            style: ButtonStyle(
                                                backgroundColor: WidgetStatePropertyAll(theme.splashColor)
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return SizedBox.shrink();
                                  },
                                )
                              ],
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(height: 20.h,),
                              Center(
                                child: Text('No comments yet',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15.sp
                                  ),),
                              ),
                              Text('Say something to start the conversation',
                                style: GoogleFonts.poppins(
                                    color: Theme.of(context).brightness==Brightness.light?
                                    Colors.black54 : Colors.white54,
                                    fontSize: 15.sp
                                ),
                              ),

                            ],
                          ),
                        ),
                      const Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 5.h),
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness==Brightness.light?
                                Colors.black12 : Colors.white12,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: TextFormField(
                                controller: _commentController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Add a comment',
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10.w)
                                ),
                                style: TextStyle(
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold

                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          if(state is CommentInsertLoading)
                            const CircularProgressIndicator()
                          else
                            InkWell(
                                onTap: (){
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  context.read<CommentCubit>().insertComments(_commentController.text);
                                  _commentController.text='';
                                },
                                child: Icon(Icons.send,color: Colors.blue,size: 25.sp,)
                            ),
                        ],
                      )
                    ],
                  );
                }
                else if(state is NotLoggedIn){
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>Login()));
                  });
                }
                return Container();
              },
              listener: (context,state){
                if(state is CommentLoaded && state.list.isNotEmpty && !state.hasReachedMax){
                  if(_isUserReachedAtLastItem()) {
                    _scrollToLastItem();
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _scrollToLastItem(){
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _setScrollListener(){

    final commentScrollCubit= context.read<CommentScrollCubit>();
    _scrollController.addListener((){
      if(_isUserReachedAtLastItem()){
        commentScrollCubit.hideScrollArrowDownIcon();
      }
      else {
        commentScrollCubit.showScrollArrowDownIcon();
      }
    });
  }

  bool _isUserReachedAtLastItem()=>_scrollController.hasClients && _scrollController.position.pixels >=
      _scrollController.position.maxScrollExtent - 100;
}
