import 'package:intl/intl.dart';

DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

class ApprovalModel {
  final String studentName;
  final String registrationNo;
  final String requestID;
  final String batch;
  final String course;
  final String roomNo;
  final String reason;
  final String destination;
  final String parentContactNumber;
  final String transport;
  bool talkedToParent;
  String remarks;
  String startDate;

  String endDate;
  bool read;
  bool approve;

  ApprovalModel(
      {this.studentName,
      this.requestID,
      this.startDate,
      this.endDate,
      this.read = false,
      this.registrationNo,
      this.batch,
      this.course,
      this.destination,
      this.parentContactNumber,
      this.reason,
      this.roomNo,
      this.talkedToParent = false,
      this.approve = false,
      this.transport});

  static final List<ApprovalModel> dummyData = [
    ApprovalModel(
      studentName: "Aditya Singhai",
      requestID: "89829849",
      startDate: dateFormat.format(DateTime.now()),
      endDate: dateFormat.format(DateTime.now()),
      registrationNo: "189214023",
      batch: "2022",
      course: "Information Technology",
      destination: "Indore",
      transport: "Bus",
      parentContactNumber: "68465168184",
      reason: "Diwali",
      roomNo: "B2-361",
    ),
    ApprovalModel(
      studentName: "Aakarshak Arora",
      requestID: "89829849",
      startDate: dateFormat.format(DateTime.now()),
      endDate: dateFormat.format(DateTime.now()),
      registrationNo: "189214023",
      batch: "2022",
      course: "Information Technology",
      destination: "Gurugram",
      transport: "Train",
      parentContactNumber: "68454951981",
      reason: "Diwali",
      roomNo: "B2-018",
    ),
    ApprovalModel(
      studentName: "Manasi Potnis",
      requestID: "89829849",
      startDate: dateFormat.format(DateTime.now()),
      endDate: dateFormat.format(DateTime.now()),
      registrationNo: "184198453",
      batch: "2022",
      course: "Information Technology",
      destination: "Mumbai",
      transport: "Flight",
      parentContactNumber: "68465168184",
      reason: "Diwali",
      roomNo: "G2-200",
    ),
  ];
}
