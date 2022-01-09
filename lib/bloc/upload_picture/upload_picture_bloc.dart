import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'upload_picture_event.dart';
part 'upload_picture_state.dart';

class UploadPictureBloc extends Bloc<UploadPictureEvent, UploadPictureState> {
  UploadPictureBloc() : super(UploadPictureInitial()) {
    on<UploadPictureEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
