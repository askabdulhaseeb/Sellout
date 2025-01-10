import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'status_type.g.dart';

const Color _blueBG = Color.fromARGB(255, 215, 235, 248);
const Color _orangeBG = Color.fromARGB(255, 245, 230, 207);
const Color _greenBG = Color.fromARGB(255, 222, 246, 220);
const Color _redBG = Color.fromARGB(255, 252, 223, 221);

@HiveType(typeId: 35)
enum StatusType {
  @HiveField(0)
  pending('pending', 'pending', Colors.blue, _blueBG),
  @HiveField(1)
  inprogress('inprogress', 'inprogress', Colors.orange, _orangeBG),
  @HiveField(2)
  accepted('accepted', 'accepted', Colors.green, _greenBG),
  @HiveField(3)
  rejected('rejected', 'rejected', Colors.red, _redBG),
  @HiveField(4)
  cancelled('cancelled', 'cancelled', Colors.red, _redBG),
  @HiveField(5)
  completed('completed', 'completed', Colors.green, _greenBG),
  @HiveField(6)
  delivered('delivered', 'delivered', Colors.green, _greenBG),
  @HiveField(7)
  shipped('shipped', 'shipped', Colors.green, _greenBG);

  const StatusType(this.code, this.json, this.color, this.bgColor);
  final String code;
  final String json;
  final Color color;
  final Color bgColor;

  static StatusType fromJson(String? map) {
    if (map == null) return StatusType.pending;
    switch (map) {
      case 'pending':
        return StatusType.pending;
      case 'accept' || 'accepted' || 'approve' || 'approved':
        return StatusType.accepted;
      case 'reject' || 'rejected':
        return StatusType.rejected;
      case 'cancel' || 'cancelled':
        return StatusType.cancelled;
      case 'complet' || 'completed':
        return StatusType.completed;
      case 'inprogress' || 'processing':
        return StatusType.inprogress;
      case 'deliver' || 'delivered':
        return StatusType.delivered;
      case 'shipped':
        return StatusType.shipped;
      default:
        return StatusType.pending;
    }
  }
}
