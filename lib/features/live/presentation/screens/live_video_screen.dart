import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shawn/features/live/presentation/cubit/comment_scroll_down_cubit.dart';
import 'package:shawn/features/live/presentation/widgets/live_comment_user_image.dart';
import 'package:shawn/features/live/presentation/widgets/live_comments_dialog.dart';
import 'package:shawn/features/live/presentation/widgets/live_description.dart';

import '../../../../show_webview.dart';
import '../../../../utils/convert_utils.dart';
import '../cubit/comment_cubit.dart';

class LiveVideoScreen extends StatelessWidget {
  const LiveVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final socialLinks= ['instagram', 'youtube', 'x', 'facebook','whatsapp', 'tiktok'];
    List<String> socialMediaLinks= socialLinks.where((link) => link.isNotEmpty).toList();
    double topPadding= MediaQuery.paddingOf(context).top;  //status bar or notch height etc
    final theme= Theme.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (create)=>CommentCubit()..fetchComments()),
        BlocProvider(create: (create)=>CommentScrollCubit()),
      ],
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              SizedBox(height: 0.25.sh,),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('hh',
                          style: theme.textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(height: 5.h,),
                        Row(
                          children: [
                            Text('${ConvertUtils.formatNumber(int.parse('444'))} views',
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: theme.textTheme.titleSmall?.color?.withValues(alpha: 0.55)
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            SizedBox(width: 10.w,),
                            Text(ConvertUtils.getTimeDiff('2025-07-21T14:30:00'),
                              style: theme.textTheme.titleSmall?.copyWith(
                                  color: theme.textTheme.titleSmall?.color?.withValues(alpha: 0.55)
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            SizedBox(width: 10.w,),
                            Builder(
                              builder: (context) {
                                return InkWell(
                                  onTap: (){
                                    _showDialog(context: context, topPadding: topPadding, isDescription: true);
                                  },
                                  child: Text("...more",
                                    style: theme.textTheme.titleSmall?.copyWith(
                                        color: theme.textTheme.titleSmall?.color?.withValues(alpha: 0.55)
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                );
                              }
                            ),
      
                          ],
                        ),
      
                        SizedBox(height: 20.h,),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for(String link in socialMediaLinks)
                                Padding(
                                  padding: EdgeInsets.only(right: 20.w),
                                  child: InkWell(
                                    onTap: ()=>_launchUrl(context,link),
                                    child: SvgPicture.asset(_socialImg(link),
                                      height: 30.w,
                                      width: 30.w,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
      
                        if(1==1)
                          SizedBox(height: 20.h,),
      
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton.icon(
                                onPressed: (){
                                  // _share(context);
                                },
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                    theme.brightness==Brightness.light?
                                    Colors.black12 : Colors.white12,),
                                  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w)),
                                ),
                                label: Text("Share",
                                  style: theme.textTheme.titleSmall,
                                ),
                                icon: Icon(Icons.share,size: 15.sp,),
                              ),
                              SizedBox(width: 20.w,),
      
                              TextButton.icon(
                                onPressed: (){
                                  // _showReportDialog(context);
                                },
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      theme.brightness==Brightness.light?
                                      Colors.black12 : Colors.white12
                                  ),
                                  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w)),
                                ),
                                label: Text("Report",
                                  style: theme.textTheme.titleSmall,
                                ),
                                icon: Icon(Icons.report,size: 15.sp,),
                              ),
                              SizedBox(width: 20.w,),
      
                              TextButton.icon(
                                onPressed: (){
                                  // _showBlockDialog(context);
                                },
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      theme.brightness==Brightness.light?
                                      Colors.black12 : Colors.white12
                                  ),
                                  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w)),
                                ),
                                label: Text("Block",
                                  style: theme.textTheme.titleSmall,
                                ),
                                icon: Icon(Icons.block,size: 15.sp,),
                              ),
                              SizedBox(width: 20.w,),
      
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        BlocBuilder<CommentCubit,FetchCommentState>(
                          builder: (BuildContext context, state) {
                            // if(state is CommentLoading){
                            //   return const Center(child: CircularProgressIndicator(color: Colors.black,));
                            // }
                            if(state is CommentLoaded){
                              // print('1. $state ${state.list.length}');
                              final firstComment= state.list.isNotEmpty? state.list[0] : null;
                              return InkWell(
                                onTap: () {
                                  // context.read<DesCommCubit>()
                                  //     .showComment();
                                  _showDialog(context: context, topPadding: topPadding, isDescription: false,);
                                },
                                  borderRadius: BorderRadius.circular(10.r),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).brightness==Brightness.light?
                                      Colors.black12 : Colors.white12,
                                      borderRadius: BorderRadius
                                          .circular(10.r)
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.h,
                                      horizontal: 10.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Live Comments',
                                        style: theme.textTheme.titleMedium,
                                      ),
                                      SizedBox(height: 5.h,),
                                      if(firstComment!=null)
                                        Row(
                                          children: [
                                            LiveCommentUserImage(name: firstComment.name,image: firstComment.image,),
                                            SizedBox(width: 10.w,),
                                            Expanded(
                                              child: Text(firstComment.comment,
                                                style: theme.textTheme.bodySmall,
                                                maxLines: 2,
                                                overflow: TextOverflow
                                                    .ellipsis,
                                              ),
                                            ),
                                          ],
                                        )
                                      else
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).brightness==Brightness.light?
                                            Colors.black12 : Colors.white12,
                                            borderRadius: BorderRadius.circular(10.r),
                                          ),
                                          child: Text(
                                            'Add a comment...',
                                            style: theme.textTheme.bodySmall,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            else{
                              return Container();
                            }
                          },
                        ),
      
                        SizedBox(height: 20.h,),
      
                        // SizedBox(height: 10.h,),
                        // Expanded(
                        //   child: ListView.separated(
                        //       itemCount: 10,
                        //       itemBuilder: (context,index){
                        //         return const ExpandedNewsBlock();
                        //       },
                        //       separatorBuilder: (BuildContext context, int index)=>SizedBox(height: 20.h,)
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog({required BuildContext context, required double topPadding,
    required bool isDescription, }){
    final dialogHeight= 1.sh-(0.25.sh+topPadding);

    showBottomSheet(
        context: context,
        constraints: BoxConstraints.expand(
            width: double.infinity,
            height: dialogHeight
        ),
        clipBehavior: Clip.none,
        shape: const LinearBorder(),
        builder: (context){
          return isDescription?
          LiveDescription(
              title: 'title',
              description: 'description',
              date: '2025-07-21T14:30:00',
              views: 100
          )
              :
          LiveCommentsDialog();
        }
    );
  }

  String _socialImg(String link){
    if(link.contains('instagram')){
      return 'assets/icons/ic_instagram.svg';
    }
    else if(link.contains('facebook')){
      return 'assets/icons/ic_facebook.svg';
    }
    else if(link.contains('whatsapp')){
      return 'assets/icons/ic_whatsapp.svg';
    }
    else if(link.contains('tiktok')){
      return 'assets/icons/ic_tiktok.svg';
    }
    else if(link.contains('x')){
      return 'assets/icons/ic_x.svg';
    }
    else if(link.contains('youtube')){
      return 'assets/icons/ic_youtube.svg';
    }
    return '';
  }

  void _launchUrl(BuildContext context, String url) {
    // if (await canLaunchUrl(Uri.parse(url))) {
    // await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    // } else {
    // throw 'Could not launch $url';
    // }
    Navigator.push(context, MaterialPageRoute(builder: (builder)=>ShowWebView(link: 'http$url'.trim().replaceAll(',', ''))));
  }
}


