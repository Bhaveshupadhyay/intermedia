import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';
import 'package:shawn/core/common/widgets/loader.dart';
import 'package:shawn/core/common/widgets/shimmer_loader.dart';
import 'package:shawn/core/theme/app_color.dart';
import 'package:shawn/utils/convert_utils.dart';
import 'package:video_player/video_player.dart';


class ShortVideoWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final int index;
  final String title;
  final String description;
  final String contentCategory;
  final int likes;
  final String posterImg;
  const ShortVideoWidget({super.key, required this.index, required this.controller, required this.title, required this.likes, required this.posterImg, required this.description, required this.contentCategory});

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: (){},
          child: controller.value.isInitialized ?
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          )
              :
          Center(child: Loader()),
        ),
        Positioned.fill(
          left: 10.w,
          right: 10.w,
          bottom: 20.h,
          child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              spacing: 20.w,
              // mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    spacing: 8.h,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 10.w,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 60.w,
                            height: 65.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              image: DecorationImage(
                                image: NetworkImage('https://image.tmdb.org/t/p/w1280/$posterImg'),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                          Flexible(
                            child: Column(
                              spacing: 5.h,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                      fontSize: 17.sp,
                                      color: AppColors.white,
                                    fontWeight: FontWeight.w600
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                _glassyContainer(
                                  padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
                                    child: Text(contentCategory,
                                      style: theme.textTheme.bodySmall?.copyWith(
                                          fontSize: 13.sp,
                                          color: AppColors.white
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),

                      Text(description,
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w200
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      _glassyContainer(
                        padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                        child: Row(
                          spacing: 8.w,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_arrow,size: 18.sp, color: AppColors.white),
                            Text('Watch Now',
                              style: theme.textTheme.bodySmall?.copyWith(
                                  fontSize: 18.sp,
                                  color: AppColors.white
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    spacing: 25.h,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                      LikeButton(
                        circleColor:
                        CircleColor(start: AppColors.red, end: AppColors.red.shade500),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: AppColors.red,
                          dotSecondaryColor: AppColors.red.shade500,
                        ),
                        mainAxisAlignment: MainAxisAlignment.end,
                        countPostion: CountPostion.bottom,
                        size: 45.sp,
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            isLiked ? Icons.favorite : Icons.favorite_outline_rounded,
                            color: isLiked ? AppColors.red : AppColors.white,
                            size: 35.sp,
                          );
                        },
                        likeCount: likes,
                        likeCountPadding: EdgeInsets.only(top: 4.h),
                        countDecoration: (w,count){
                          return Text(
                            ConvertUtils.formatNumber(count??0),
                            style: theme.textTheme.bodySmall,
                          );
                        },
                        countBuilder: (int? count, bool isLiked, String text) {
                          var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                          Widget result;
                          if (count == 0) {
                            result = Text(
                              "love",
                              style: theme.textTheme.bodySmall,
                            );
                          } else {
                            result = Text(
                              ConvertUtils.formatNumber(count??0),
                              style: TextStyle(
                                color: color,
                              ),
                            );
                          }
                          return result;
                        },
                      ),
                      _sideButton(
                          theme: theme,
                          icon: Icons.mode_comment_outlined,
                          iconColor: AppColors.white,
                          text: ConvertUtils.formatNumber(8500),
                          onTap: (){

                          }
                      ),
                      _sideButton(
                          theme: theme,
                          icon: Icons.share,
                          iconColor: AppColors.white,
                          text: 'Share',
                          onTap: (){

                          }
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _sideButton({required ThemeData theme, required IconData icon, Color? iconColor, required String text, required VoidCallback onTap})=>
      GestureDetector(
        onTap: onTap,
        child: Column(
          spacing: 4.h,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 35.sp,
              shadows: [
                Shadow(color: Colors.black.withValues(alpha: 0.4), blurRadius: 8.0)
              ],
            ),
            Text(
              text,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      );

  Widget _glassyContainer({required Widget child, required EdgeInsets padding})=>
      Container(
        padding: padding,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.grey.withValues(alpha: 0.45)
        ),
        child: child
      );
}
