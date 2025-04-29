Create a small PHP application that displays an account creation form, validates the input,
and shows a confirmation message upon submission. No need to store the details in a
database.
The form must include the following fields:
• Name
• Gender
• Phone Number
• Date of Birth
• Email
• Password

Upon successful submission, hide the form and display a confirmation message that includes
some of the entered data. For example:
"Thank you <name>, for creating an account on our platform. You will receive more details
at <email>."

Technical Requirements
• Use a PHP controller to load the page. The specific way you load it is up to you.
• Show an indicator for any field with an empty or invalid input, allowing users to
identify and fix issues easily. You can use either frontend or backend validation.
• Use a calendar picker for the Date of Birth field. Feel free to use any available library.
• The minimum validation rules that must be applied are the following:
1. No field can be empty.
2. Phone numbers must be numeric.
3. Emails must follow a valid format.
4. Passwords must be at least 8 characters long.
