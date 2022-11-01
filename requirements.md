## Functional requirements:
1. Display a circular progress indicator when there are no previous posts to display in the List Screen.
2. The List Screen should display a list of all previous posts, with the most recent at the top of the list.
3. Each post in the List Screen should be displayed as a date, representing the date the post was created, and a number, representing the total number of wasted items recorded in the post.
4. Tapping on a post in the List Screen should cause a Detail Screen to appear. The Detail Screen's back button should cause the List Screen to appear.
5. The Detail Screen should display the post's date, photo, number of wasted items, and the latitude and longitude that was recorded as part of the post.
6. The List Screen should display a large button at the center bottom area of the screen.
7. Tapping on the large button enables an employee to capture a photo, or select a photo from the device's photo gallery.
8. After taking a new photo or selecting a photo from the gallery, the New Post screen appears.
9. The New Post screen displays the photo of wasted food, a Number of Items text input field for entering the number of wasted items, and a large upload button for saving the post.
10. Tapping on the Number of Items text input field should cause the device to display its numeric keypad.
11. In the New Post screen, tapping the back button in the app bar should cause the List Screen to appear.
12. In the New Post screen, tapping the large upload button should cause the List Screen to appear, with the latest post now appearing at the top of the list.
13. In the New Post screen, if the Number of Items field is empty, tapping the upload button should cause a sensible error message to appear.

## Technical requirements:
1. Use the location, image_picker, cloud_firestore, and firebase_storage packages to meet the functional and technical requirements.
2. Incorporate the use of Firebase Cloud Storage and Firebase Cloud Firestore for storing images and post data.
3. Data should not be stored locally on the device.
4. On the List Screen, the application should display the posts stored in the Firestore database.
5. On the Detail Screen, the application should display the image stored in the Cloud Storage bucket.
6. On the New Post screen, tapping the large upload button should store a new post in the Firestore database.
7. Each "post" in Firestore should have the following attributes: date, imageURL, quantity, latitude and longitude.
8. The application should incorporate the Semantics widget in multiple places, such as interactive widgets like buttons, to aid accessibility.
9. The codebase should incorporate a model class.
10. he codebase should incorporate a few (two or three) simple unit tests that test the model class.
