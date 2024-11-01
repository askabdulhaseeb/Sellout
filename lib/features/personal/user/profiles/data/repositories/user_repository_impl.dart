import '../../../../../../core/sources/data_state.dart';
import '../../../../post/domain/entities/post_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repositories.dart';
import '../sources/remote/post_by_user_remote.dart';
import '../sources/remote/user_profile_remote_source.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  const UserProfileRepositoryImpl(
      this.userProfileRemoteSource, this.postByUserRemote);
  final UserProfileRemoteSource userProfileRemoteSource;
  final PostByUserRemote postByUserRemote;
  @override
  Future<DataState<UserEntity?>> byUID(String uid) async {
    return await userProfileRemoteSource.byUID(uid);
  }

  @override
  Future<DataState<List<PostEntity>>> getPostByUser(String? uid) async {
    return await postByUserRemote.getPostByUser(uid);
  }
}
