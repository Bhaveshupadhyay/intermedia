
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shawn/core/common/model/comment_model.dart';
import 'package:shawn/core/theme/app_color.dart';

import '../../../../utils/convert_utils.dart';
import 'live_comment_user_image.dart';

class CommentWidget extends StatelessWidget {
   final CommentModel commentModal;
   final bool isReplyScreen;

   const CommentWidget(
      {required this.commentModal,
   super.key, required this.isReplyScreen}); // const CommentWidget({super.key});


  @override
  Widget build(BuildContext context) {
    final theme= Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LiveCommentUserImage(name: commentModal.name,image: commentModal.image,),
        SizedBox(width: 15.w,),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(commentModal.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontSize: 14.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 5.w,),

                  Text(ConvertUtils.getRelativeTime('1753339847', commentModal.usaTimestamp),
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 10.sp,
                      color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.5)
                    ),
                  ),
                  SizedBox(width: 10.w,),
                ],
              ),
              SizedBox(height: 5.h,),
              Text(commentModal.comment,
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 13.sp,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
