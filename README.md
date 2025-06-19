
# HotelBookingSystem

The **HotelBookingSystem** is a web-based application designed to manage hotel bookings, reviews, and administrative functionalities. It allows users to search, book rooms, and leave reviews, while administrators can manage room listings, reviews, and user data.

## Features

* **User Authentication**: Users can log in and access their account information.
* **Room Management**: Admins can add, edit, and manage rooms available for booking, including setting prices, descriptions, and room features.
* **Booking System**: Users can view available rooms and make reservations.
* **Reviews System**: Users can leave reviews and ratings for rooms, and admins can manage these reviews.
* **Email Confirmation**: After registration, users receive an email to confirm their account.
* **Admin Dashboard**: Admins have access to all functionalities, such as adding rooms, viewing all reviews, and managing accounts.

## Technologies Used

* **ASP.NET WebForms**: For the front-end web interface.
* **C#**: For back-end logic, including database interactions and session management.
* **AES Encryption**: For encrypting sensitive data, such as user IDs.
* **SMTP (Simple Mail Transfer Protocol)**: To send confirmation emails to users.
* **Web Services**: Exposed functions for managing accounts, reviews, and room data.

## Getting Started

### Prerequisites

1. **Clone the repository**:
   To get started, clone this repository to your local machine.

   ```bash
   git clone https://github.com/your-username/HotelBookingSystem.git
   ```

2. **Set up the database**:
   Make sure you configure the database and the necessary tables for rooms, users, and reviews.

3. **Build the project**:
   Open the project in Visual Studio and build it to resolve dependencies.

4. **Run the application**:
   Start the application using the built-in server and navigate to `Home.aspx` in your browser.

### Available WebMethods

* **User Management**:

  * `loginto(string username, string pass)`: Logs in the user and checks credentials.
  * `getaccounts(int id)`: Fetches account information for a specific user.
  * `updateaccstatus(String id)`: Updates the status of a user account.

* **Room Management** (Admin Only):

  * `addroom(string price, string descp, string type, string name)`: Adds a new room to the system.
  * `addpics(string pics, int id)`: Adds pictures for a room.
  * `addfeatures(string features, int id)`: Adds features for a specific room.

* **Reviews Management**:

  * `addreview(string name, string email, string cno, string comment, int rating)`: Allows users to add reviews.
  * `getreviews()`: Retrieves all the reviews available in the system.
  * `deletereview(int rid)`: Deletes a review by ID (Admin Only).
  * `averagerating()`: Retrieves the average rating of rooms.

* **Email Management**:

  * `sendemail(string email, string domain)`: Sends a confirmation email to the user.

