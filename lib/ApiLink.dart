class ApiLink{
  static String baseLink="http://192.168.54.52:8000/";
  static String userRegistrationApi=baseLink +'register/';
  static String userLoginApi=baseLink +'loginUser/';
  static String deleteUserAcApi=baseLink +'deleteUser/';
  static String updateUserProfileApi=baseLink +'updateUserProfile/';
  static String updateUserPasswordApi=baseLink +'updateUserPassword/';
  static String registerComplaint=baseLink +'complaints/';
  static String getRegisteredGrievance=baseLink +'get_registered_Complaints/';
  static String getAllRegisteredGrievance=baseLink +'get_all_registered_Complaints/';
  static String getPendingGrievance=baseLink +'get_pending_Complaints/';
  static String getAllPendingGrievance=baseLink +'get_all_pending_Complaints/';
  static String getResolvedGrievance=baseLink +'get_resolved_Complaints/';
  static String getAllResolvedGrievance=baseLink +'get_all_resolved_Complaints/';
  static String getRejectedGrievance=baseLink +'get_rejected_Complaints/';
  static String getAllRejectedGrievance=baseLink +'get_all_rejected_Complaints/';
  static String getGrievanceDetails=baseLink +'search_complaints/';
  static String updateGrievanceStatus=baseLink +'update_complaint_status/';
}