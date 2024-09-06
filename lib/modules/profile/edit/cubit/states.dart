abstract base class EditProfileScreenStates{}

final class EditProfileScreenInitialState extends EditProfileScreenStates{}

final class EditProfileScreenGotImageState extends EditProfileScreenStates{}

final class EditProfileScreenImageErrorState extends EditProfileScreenStates{}

///////////
//image upload states
final class ImageUploadLoadingState extends EditProfileScreenStates{}// not used

final class SuccessfulImageUploadState extends EditProfileScreenStates{} // not used

final class ImageUploadErrorState extends EditProfileScreenStates{}

///////////////
// user status

final class UserUpdateLoadingState extends EditProfileScreenStates{}

final class SuccessfulUserUpdateState extends EditProfileScreenStates{}

final class UserUpdateErrorState extends EditProfileScreenStates{}