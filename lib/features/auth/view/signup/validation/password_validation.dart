
//Function validatePasswordLength
//Description: This function will validate the length of the password
validatePasswordLength(String password)
{
  if(password.length < 8) {return -1;} 
  else {return 0;}
}


//Function  passwordMatch
//Description: This function will check if the password and confirm password match
//Return: 0 if the passwords match, -1 if they do not match
passwordMatch(String password, String confirmPassword)
{
  if(password == confirmPassword) {return 0;} 

  else{return -1; }
}


// Function: validatePassword
// Description: This function will validate the password to make sure it meets requirements
// Requirements 
// 1. Password must contain at least one uppercase letter
// 2. Password must contain a special character ex. !@#$%^
validatePasswordForSpecialCharacters(String password)
{
  if(password.contains( new RegExp(r'[A-Z]')) && password.contains(new RegExp(r'[!@#$%^]'))) {return 0;}
  else {return -1;}
}


