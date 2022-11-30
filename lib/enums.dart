enum LoginCardPage{
  login,
  signup,
}

enum UserType{
  doctor,
  patient,
  admin
}

enum PatientScreen{
  home,
  payments,
  reserveAppointment,
  profile,
}

enum DoctorScreen{
  home,
  profile,
}

enum AdminScreen{
  payments,
  users,
}


enum LoginStatus{
  failed,
  success,
  accountBanned,
}