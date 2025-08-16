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
  final int likes;
  final String logo;
  const ShortVideoWidget({super.key, required this.index, required this.controller, required this.title, required this.likes, required this.logo});

  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: (){},
          child: Center(
            child: controller.value.isInitialized ?
            AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            )
                :
            Loader(),
          ),
        ),
        Positioned.fill(
          left: 10.w,
          child: Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: SizedBox(
                width: 0.45.sw,
                height: 0.2.sw,
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/original/$logo',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          left: 10.w,
          right: 10.w,
          child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              spacing: 20.w,
              // mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Text(title,
                        style: theme.textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
                          text: ConvertUtils.formatNumber(850100),
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

                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.r),
                        child: CachedNetworkImage(
                            imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/Zayn_Wiki_%28cropped%29.jpg/960px-Zayn_Wiki_%28cropped%29.jpg',
                          width: 45.w,
                          height: 45.w,
                          placeholder: (context,s){
                              return ShimmerLoader(width: 45.w,height: 45.w,);
                          },
                          fit: BoxFit.cover,
                        ),
                      )

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
}
