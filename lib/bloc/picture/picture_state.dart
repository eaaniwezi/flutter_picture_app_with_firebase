part of 'picture_bloc.dart';

abstract class PictureState extends Equatable {
  const PictureState();

  @override
  List<Object> get props => [];
}

class PictureInitialState extends PictureState {}

class PictureFetchingState extends PictureState {}

class PictureFetchedState extends PictureState {
  final List<PictureModel> pictureItemModelList;
  const PictureFetchedState({
    required this.pictureItemModelList,
  });
}

class PictureErrorState extends PictureState {}

//*
class PictureFetchingErrorState extends PictureState {}

class PictureLoadingState extends PictureState {}

class PictureLoadedState extends PictureState {}

//*
class PictureDeletingState extends PictureState {}

class PictureDeletedState extends PictureState {}

class PictureErrorDeletingState extends PictureState {}
