# Umee Hackathon Project
Video demo https://youtu.be/d1d4Ns_IQkI

## Overview
This project is a mobile newsfeed application built using Flutter. The app allows users to view a newsfeed, add new posts, like/unlike posts, and save posts for later viewing. The app ensures that the user interface is intuitive and user-friendly, adhering to best practices in UI/UX design.

<img width="320" alt="Screenshot 2024-07-25 at 10 16 20 AM" src="https://github.com/user-attachments/assets/83d2582e-2cef-429c-a9f0-dfb22e6fc5b4">
<img width="320" alt="Screenshot 2024-07-25 at 10 16 44 AM" src="https://github.com/user-attachments/assets/0da05941-fce4-4a36-a196-caadb6692d7e">
<img width="320" alt="Screenshot 2024-07-25 at 10 16 30 AM" src="https://github.com/user-attachments/assets/b98b697a-e7cb-4a33-b655-65813bfba44d">

## Features
- **View Newsfeed:** Display a list of posts, including the user's name, post content, timestamp, like count, and like button.
- **Add New Post:** Allow users to add text content and publish new posts.
- **Like/Unlike Post:** Users can like or unlike posts, with the like count updating accordingly.
- **Persist Data:** Posts and like counts are saved locally to ensure data remains available after the app is closed and reopened.
- **Save Post:** Users can save posts for later viewing, with saved posts accessible from a dedicated screen.
- **User Authentication:** Simple user authentication with a username entry for demonstration purposes.

## Getting Started
### Prerequisites
- Flutter SDK
- Dart SDK

### Installation
1. Clone the repository:
    ```bash
    git clone https://github.com/tsrinarmwong/umee_hackathon.git
    cd umee_hackathon
    ```
2. Install dependencies:
    ```bash
    flutter pub get
    ```
3. Run the app:
    ```bash
    flutter run
    ```

## Usage
1. **Login:** Enter a username to log in.
2. **View Newsfeed:** Browse through the list of posts in the newsfeed.
3. **Add Post:** Click on the '+' button to add a new post. Enter the post content and publish it.
4. **Like/Unlike Post:** Click on the like button to like/unlike a post. The like count will update accordingly.
5. **Save Post:** Click on the bookmark icon to save/unsave a post. Access saved posts from the saved posts screen.

## Project Structure
- **lib/screens:** Contains the different screens of the application.
- **lib/models:** Contains the data models for the application.
- **lib/blocs:** Contains the BLoC classes for managing state.
- **lib/services:** Contains the local storage service for persisting data.
- **lib/widgets:** Contains reusable widgets used throughout the app.

## Contribution
1. Fork the repository.
2. Create a new branch:
    ```bash
    git checkout -b feature-branch
    ```
3. Make your changes and commit them:
    ```bash
    git commit -m 'Add some feature'
    ```
4. Push to the branch:
    ```bash
    git push origin feature-branch
    ```
5. Open a pull request.

## Maintainers
- Timo (Thitipun) Srinarmwong

## Helpful Hints
- Ensure the code is well-structured, readable, and maintainable.
- The UI should be intuitive and user-friendly.
- Additional features should add value to the newsfeed.
- Ensure the README file is clear and helpful.

## TODO Bugs
- Toggle like/unlike per user.
- Fix load post that returns all of the posts as saved.
- Add navigation from create post to newsfeed.
- Add image in post.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact
For help or queries, please contact Timo at [tsrinarmwong.careers@gmail.com].
