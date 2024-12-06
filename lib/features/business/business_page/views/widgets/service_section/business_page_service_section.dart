import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/sources/data_state.dart';
import '../../../../core/data/sources/service/local_service.dart';
import '../../../../core/domain/entity/business_entity.dart';
import '../../../../core/domain/entity/service/service_entity.dart';
import '../../../domain/entities/services_list_responce_entity.dart';
import '../../providers/business_page_provider.dart';
import '../business_page_employee_list_section.dart';
import 'tile/business_page_service_tile.dart';

class BusinessPageServiceSection extends StatelessWidget {
  const BusinessPageServiceSection({required this.business, super.key});
  final BusinessEntity business;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        BusinessPageEmployeeListSection(business: business),
        const SizedBox(height: 10),
        Consumer<BusinessPageProvider>(builder: (
          BuildContext context,
          BusinessPageProvider pagePro,
          _,
        ) {
          return FutureBuilder<DataState<ServicesListResponceEntity>>(
            future: pagePro.getServicesListByBusinessID(business.businessID),
            builder: (
              BuildContext context,
              AsyncSnapshot<DataState<ServicesListResponceEntity>> snapshot,
            ) {
              final List<ServiceEntity> services =
                  snapshot.data?.entity?.services ??
                      LocalService().byBusinessID(business.businessID);
              return ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: services.length,
                itemBuilder: (BuildContext context, int index) {
                  final ServiceEntity service = services[index];
                  return BusinessPageServiceTile(service: service);
                },
              );
            },
          );
        }),
      ],
    );
  }
}