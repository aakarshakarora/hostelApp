class HostelInChargeField {
  String userNameHostel;
  String empIdHostel;
  String designationHostel;
  String personalEmailIdHostel;
  String collegeEmailIdHostel;
  int contactNumberHostel;

  HostelInChargeField(
      this.userNameHostel,
      this.empIdHostel,
      this.designationHostel,
      this.personalEmailIdHostel,
      this.collegeEmailIdHostel,
      this.contactNumberHostel);

  HostelInChargeField.initialize() {
    userNameHostel = "Phineas";
    empIdHostel = "236023";
    designationHostel = "Warden";
    personalEmailIdHostel = "rst@def.com";
    collegeEmailIdHostel = "lmn@abc.edu";
    contactNumberHostel = 88888888888;
  }
}
