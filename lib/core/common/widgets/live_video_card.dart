import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shawn/features/live/presentation/screens/live_video_screen.dart';

import '../../../features/about_content/presentation/screens/about_content.dart';
import '../../constant/links.dart';
import '../../theme/app_color.dart';
import '../model/continue_watching_model.dart';

class LiveVideoCard extends StatelessWidget {
  final String title;
  final List<ContinueWatchingModel> continueWatchingList;
  const LiveVideoCard({super.key, required this.title, required this.continueWatchingList});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);

    return Column(
      spacing: 20.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(title,
            style: theme.textTheme.headlineSmall,
          ),
        ),
        SizedBox(
          height: 140.h,
          child: ListView.builder(
            itemCount: continueWatchingList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index){
              final continueWatchingVideo =continueWatchingList[index];
              return Padding(
                  padding: EdgeInsets.only(left: 20.w,right: index==9? 20.w:0),
                  child: InkWell(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (builder)=>
                        LiveVideoScreen())),
                    child: SizedBox(
                      width: 180.w,
                      child: Column(
                        spacing: 5.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LayoutBuilder(
                            builder: (context,constraints){
                              return SizedBox(
                                height: 110.h,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 180.w,
                                      height: 110.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.r),
                                          image: DecorationImage(
                                              image: NetworkImage('$baseImageUrl/${continueWatchingVideo.backdropImage}',
                                              ),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    ),
                                    Positioned.fill(
                                      right: 8.w,
                                      bottom: 8.h,
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 5.w),
                                          decoration: BoxDecoration(
                                            color: AppColors.red,
                                            borderRadius: BorderRadius.circular(5.r)
                                          ),
                                          child: Row(
                                            spacing: 2.w,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/icons/ic_live.svg',
                                                height: 20.w,
                                                width: 20.w,
                                              ),
                                              Text('LIVE',
                                                style: theme.textTheme.titleSmall,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Expanded(
                            child: Text('${continueWatchingVideo.title} hdiuwedwfwyfbwfw fwgfuywgfyuwgfuwfuytftwuftu',
                              style: theme.textTheme.titleSmall,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              );
            },
          ),
        )
      ],
    );
  }
}
