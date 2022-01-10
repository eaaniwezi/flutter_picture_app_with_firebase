import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_picture_app/repository/picture_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

part 'picture_event.dart';
part 'picture_state.dart';

class PictureBloc extends Bloc<PictureEvent, PictureState> {
  final PictureRepository pictureRepository;

  PictureBloc({
    required PictureInitialState pictureInitState,
    required this.pictureRepository,
  }) : super(pictureInitState) {
    add(NoPictureEvent());
  }

  @override
  Stream<PictureState> mapEventToState(PictureEvent event) async* {
    var log = Logger();
    if (event is NoPictureEvent) {
      //!
    }
    if (event is OnTapEvent) {
      yield PictureLoadingState();
      final  imageUrl =
          pictureRepository.sendAndStorePicturesInDb(event.image.path);
      log.wtf(imageUrl);
      pictureRepository.createPictureCollectionInFireStore({
        "picture": imageUrl.toString(),
      });
      yield PictureLoadedState();
    }
  }
}
