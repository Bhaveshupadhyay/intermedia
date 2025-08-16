import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shawn/core/common/state/data_state.dart';
import 'package:shawn/core/constant/login_device_reason_code.dart';
import 'package:shawn/core/service/failure.dart';
import 'package:shawn/core/service/network_api.dart';
import 'package:shawn/features/video_play/model/video_model.dart';
import 'package:shawn/features/video_play/model/video_quality_model.dart';

class VideoLinkCubit extends Cubit<DataState>{
  VideoLinkCubit():super(DataInitial());

  Future<void> getTrailer({required int contentId, required int contentType,}) async {
    emit(DataLoading());
    final res= await DioApi().getTrailerVideoLink(contentId: contentId, contentType: contentType);
    if(isClosed) return;

    res.fold(
            (failure){
              emit(DataFailed(failure: Failure(msg: failure.msg)));
            },
            (data){
              emit(DataLoaded<List<VideoQualityModel>>(data: data));
            }
    );

  }

  Future<void> getVideo({required int contentId, required int contentType,}) async {
    emit(DataLoading());
    final res= await DioApi().getVideo(contentId: contentId, contentType: contentType);
    if(isClosed) return;

    res.fold(
            (failure){
              emit(DataFailed(failure: Failure(msg: failure.msg)));
            },
            (data){
              if(data.reasonCode== LoginDeviceReasonCode.deviceLoginSuccessful){
                emit(DataLoaded<VideoModel>(data: data));
              }
              else{
                emit(DataFailed(failure: Failure(msg: LoginDeviceReasonCode.getMessage(data.reasonCode)),reasonCode: data.reasonCode));
              }
            }
    );

  }

}

// sealed class VideoDataState extends