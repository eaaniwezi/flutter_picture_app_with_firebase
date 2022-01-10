part of 'picture_bloc.dart';

abstract class PictureState extends Equatable {
  const PictureState();

  @override
  List<Object> get props => [];
}

class PictureInitialState extends PictureState {}

class PictureLoadingState extends PictureState {}

class PictureLoadedState extends PictureState {}

class PictureErrorState extends PictureState {}
