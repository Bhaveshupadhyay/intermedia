
class CommentModel{
  final int commentId;
  final int userId;
  final String comment;
  final int? likes;
  final int? dislikes;
  final String date;
  final String name;
  final String? image;
  final bool showReplies;
  final int usaTimestamp;

  CommentModel.fromJson(Map<String,dynamic> json, this.usaTimestamp):
        commentId=json['id'],
        userId=json['user_id'],
        comment=json['text'],
        likes=json['likes'],
        dislikes=json['dislikes'],
        date=json['date'],
        name=json['name'],
        image=json['image'],
        showReplies=int.parse(json['replies'].toString())>0;

  CommentModel({
    required this.commentId,
    required this.userId,
    required this.comment,
    this.likes,
    this.dislikes,
    required this.date,
    required this.name,
    this.image, 
    this.showReplies=false,
    required this.usaTimestamp
  });
}