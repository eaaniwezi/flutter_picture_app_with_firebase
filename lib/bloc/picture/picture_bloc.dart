import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_picture_app/models/picture_model.dart';
import 'package:firebase_picture_app/repository/picture_repository.dart';
import 'package:firebase_picture_app/repository/user_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

part 'picture_event.dart';
part 'picture_state.dart';

class PictureBloc extends Bloc<PictureEvent, PictureState> {
  final PictureRepository pictureRepository;
  final UserRepository userRepository;
  var log = Logger();

  PictureBloc({
    required PictureInitialState pictureInitState,
    required this.pictureRepository,
    required this.userRepository,
  }) : super(pictureInitState) {
    add(NoPictureEvent());
  }

  @override
  Stream<PictureState> mapEventToState(PictureEvent event) async* {
  
    if (event is NoPictureEvent) {
      //!
      try {
        late User? _user;
        _user = await userRepository.getUser();
        final currentUserId = _user!.uid;
        late List<PictureModel> _pictureItemList;
        yield PictureFetchingState();
        _pictureItemList =
            await pictureRepository.getUserPictures(currentUserId);
        yield PictureFetchedState(pictureItemModelList: _pictureItemList);
      } catch (e) {
        yield PictureFetchingErrorState();
      }
    }
    if (event is OnTapEvent) {
      try {
        late User? _user;
        _user = await userRepository.getUser();
        final currentUserId = _user!.uid;

        yield PictureLoadingState();

        final imageUrl =
            await pictureRepository.sendAndStorePicturesInDb(event.image);
   
        pictureRepository.createPictureCollectionInFireStore({
          "picture": imageUrl.toString(),
        }, currentUserId);
        yield PictureLoadedState();

        late List<PictureModel> _pictureItemList;
        yield PictureFetchingState();
        _pictureItemList =
            await pictureRepository.getUserPictures(currentUserId);
        yield PictureFetchedState(pictureItemModelList: _pictureItemList);
      } catch (e) {
        yield PictureErrorState();
        log.w(e);
      }
    }
    if (event is DetelePictureEvent) {
      try {
        late User? _user;
        _user = await userRepository.getUser();
        final currentUserId = _user!.uid;
        yield PictureDeletingState();
        final bool isDeleted = await pictureRepository
            .deletePictureFromDbAndStorage(event.pictureModel, currentUserId);
        if (isDeleted == true) {
          yield PictureDeletedState();
        } else {
          yield PictureErrorDeletingState();
        }

        late List<PictureModel> _pictureItemList;
        yield PictureFetchingState();
        _pictureItemList =
            await pictureRepository.getUserPictures(currentUserId);
        yield PictureFetchedState(pictureItemModelList: _pictureItemList);
      } catch (e) {
        yield PictureErrorDeletingState();
        log.w(e);
      }
    }
  }

  @override
  void onChange(Change<PictureState> change) {
  log.w(change.currentState);
    super.onChange(change);
  }

  @override
  void onEvent(PictureEvent event) {
   log.w(event);
    super.onEvent(event);
  }
}
