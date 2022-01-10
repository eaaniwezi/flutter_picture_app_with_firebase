part of 'picture_bloc.dart';

abstract class PictureEvent extends Equatable {
  const PictureEvent();

  @override
  List<Object> get props => [];
}

class NoPictureEvent extends PictureEvent {}

class OnTapEvent extends PictureEvent {
  final XFile image;
  const OnTapEvent({
    required this.image,
  });
}
