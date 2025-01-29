
//Function validateEmailAddress
//Description: This function is used to validate the email address
validateEmailAddress(String email)
{
  //Check if the email is empty
  if(email.isEmpty)
  {
    return 'Email is required';
  }
  //Check if the email is valid
  else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email))
  {
    return 'Please enter a valid email address';
  }
  return null;
}


//Function validatePostalCode
//Description: This function is used to validate the postal code
//ex N0B 2T0,
validatePostalCode(String postalCode)
{
  //Check if the postal code is empty
  if(postalCode.isEmpty)
  {
    return 'Postal code is required';
  }
  //Check if the postal code is valid
  else if(!RegExp(r'^[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d$').hasMatch(postalCode))
  {
    return 'Please enter a valid postal code';
  }
  return null;
}