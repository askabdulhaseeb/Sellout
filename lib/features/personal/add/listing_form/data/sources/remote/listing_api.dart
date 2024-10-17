import 'dart:developer';

import '../../../../../../../core/entities/api_request_entity.dart';
import '../../../../../../../core/sources/api_call.dart';
import '../../../../../../../core/sources/local/local_request_history.dart';
import '../../models/listing_model.dart';
import '../local/local_listing.dart';

class ListingAPI {
  Future<List<ListingEntity>> listing() async {
    try {
      ApiRequestEntity? request = await LocalRequestHistory()
          .request(endpoint: '/category', duration: const Duration(seconds: 1));
      if (request != null) {
        final List<ListingEntity> local = LocalListing().listings;
        if (local.isNotEmpty) {
          return local;
        }
      }
      final DataState<bool> req = await ApiCall<bool>().call(
        endpoint: '/category',
        requestType: ApiRequestType.get,
        isAuth: false,
        isConnectType: false,
      );

      if (req is DataSuccess) {
        final List<dynamic> data = json.decode(req.data ?? '');
        return await _decodeData(data);
      } else if (req is DataFailer) {
        log('❌ Error ListingAPI: DataFailer -> ${req.exception?.message}');
        // Local Hive
        return await _localData('/category');
      } else {
        return await _localData('/category');
      }
    } catch (e) {
      log('❌ Error ListingAPI: catch -> $e');
      return await _localData('/category');
    }
  }

  Future<List<ListingEntity>> _localData(String endpoint) async {
    List<ListingEntity> local = LocalListing().listings;
    if (local.isNotEmpty) {
      return local;
    } else {
      // Local Request History
      ApiRequestEntity? request =
          await LocalRequestHistory().request(endpoint: endpoint);
      if (request != null) {
        final List<dynamic> data = json.decode(request.encodedData);
        return await _decodeData(data);
      } else {
        return <ListingEntity>[];
      }
    }
  }

  Future<List<ListingEntity>> _decodeData(List<dynamic> data) async {
    List<ListingEntity> listings = <ListingEntity>[];
    for (final Map<String, dynamic> item in data) {
      final ListingEntity entity = ListingModel.fromJson(item);
      listings.add(entity);
      await LocalListing().save(entity);
    }
    return listings;
  }
}
