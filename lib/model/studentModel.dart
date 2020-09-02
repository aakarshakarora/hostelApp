class StudentField {
  String studentName;
  String courseName;
  String personalEmailID;
  String collegeEmailID;
  int registrationNumber;
  int contactNumber;
  int roomNumber;
  String block;
  String occupancyType;

  StudentField(
      this.studentName,
      this.courseName,
      this.personalEmailID,
      this.collegeEmailID,
      this.registrationNumber,
      this.contactNumber,
      this.block,
      this.occupancyType,
      this.roomNumber);

  StudentField.inintalize() {
    studentName = "Oggy";
    courseName = "B.TECH IT";
    personalEmailID = "abc@def.com";
    collegeEmailID = "pqrs@xyz.edu";
    registrationNumber = 20202020;
    contactNumber = 989898989;
    roomNumber = 99;
    block = "B3";
    occupancyType = "Double";
  }
}

class ParentField {
  String parentName;
  String parentEmailID;
  int parentContactNumber;

  ParentField(this.parentName, this.parentEmailID, this.parentContactNumber);

  ParentField.inintalize() {
    parentName = "Tom";
    parentEmailID = "tom123@def.com";
    parentContactNumber = 9999999999;
  }
}

class MentorField {
  String mentorName;
  String mentorEmailID;
  int mentorContactNumber;

  MentorField(this.mentorName, this.mentorEmailID, this.mentorContactNumber);

  MentorField.inintalize() {
    mentorName = "Tom";
    mentorEmailID = "tom123@def.com";
    mentorContactNumber = 9999999999;
  }
}
