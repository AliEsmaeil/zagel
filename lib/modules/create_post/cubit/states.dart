abstract base class CreatePostScreenStates{}

final class CreatePostScreenInitialState extends CreatePostScreenStates{}

final class CreatePostScreenPopupChangedState extends CreatePostScreenStates{}

final class CreatePostScreenImagePickedState extends CreatePostScreenStates{}

final class CreatePostScreenTextChangedState extends CreatePostScreenStates{}

//// post uploading
final class CreatePostLoadingState extends CreatePostScreenStates{}

final class CreatePostSuccessfulUploadState extends CreatePostScreenStates{}

final class CreatePostFailedUploadState extends CreatePostScreenStates{}

////////////////

final class CreatePostRemoveImageState extends CreatePostScreenStates{}

