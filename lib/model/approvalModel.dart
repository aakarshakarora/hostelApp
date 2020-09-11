import 'package:intl/intl.dart';

DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

class ApprovalModel {
  final String studentName;
  final String registrationNumber;
  final String requestID;
  final String batch;
  final String courseName;
  final String roomNumber;
  final String reason;
  final String destination;
  final String parentContactNumber;
  final String modeOfTransport;
  bool consentFrom;
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
      this.registrationNumber,
      this.batch,
      this.courseName,
      this.destination,
      this.parentContactNumber,
      this.reason,
      this.roomNumber,
      this.consentFrom = false,
      this.approve = false,
      this.modeOfTransport});

  static final List<ApprovalModel> dummyData = [
    ApprovalModel(
      studentName: "Aditya Singhai",
      requestID: "89829849",
      startDate: dateFormat.format(DateTime.now()),
      endDate: dateFormat.format(DateTime.now()),
      registrationNumber: "189214023",
      batch: "2022",
      courseName: "Information Technology",
      destination: "Indore",
      modeOfTransport: "Bus",
      parentContactNumber: "68465168184",
      reason: "Diwali",
      roomNumber: "B2-361",
    ),
    ApprovalModel(
      studentName: "Aakarshak Arora",
      requestID: "89829849",
      startDate: dateFormat.format(DateTime.now()),
      endDate: dateFormat.format(DateTime.now()),
      registrationNumber: "189214023",
      batch: "2022",
      courseName: "Information Technology",
      destination: "Gurugram",
      modeOfTransport: "Train",
      parentContactNumber: "68454951981",
      reason: "Diwali",
      roomNumber: "B2-018",
    ),
    ApprovalModel(
      studentName: "Manasi Potnis",
      requestID: "89829849",
      startDate: dateFormat.format(DateTime.now()),
      endDate: dateFormat.format(DateTime.now()),
      registrationNumber: "184198453",
      batch: "2022",
      courseName: "Information Technology",
      destination: "Mumbai",
      modeOfTransport: "Flight",
      parentContactNumber: "68465168184",
      reason: "Diwali",
      roomNumber: "G2-200",
    ),
  ];
}
