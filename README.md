# ServerAccessApp

ServerAccessApp is a Ruby on Rails web application that allows users to manage server access via referral links. Administrators can create, edit, and delete servers, while regular users can add servers to their list using referral links. The app supports automatic translations (Ukrainian and English).
## Features
- **Authentication**: Registration and login via Devise.
- **User Roles**: Admins can create/edit/delete servers; regular users can add servers via referrals.
- **Referral Links**: Generate unique links to add servers.
- **Translations**: Automatic language detection (uk/en) based on browser settings with a header switcher.
- **Caching**: Uses Rails.cache to optimize the server list.

## Requirements
- Ruby 3.2+
- Rails 8.0+
- SQLite3 (default database)
- Node.js and Yarn (for JavaScript and assets)

## Installation
1. **Clone the repository**:
```bash
git clone https://github.com/OtmiVi/server_acces_app.git
cd server-access-app
```
2. **Install dependencies:**
```bash
bundle install
yarn install
```
3. **Set up the database:**
```bash
rails db:create
rails db:migrate
```
4. **Run the server:**
```bash
rails server
```
Open http://127.0.0.1:3000/ in your browser.

## Usage
1. **Registration and Login:**
Go to /users/sign_up to create an account.
Log in via /users/sign_in.

2. **Creating an Admin:**
Assign admin role in the Rails console:
```bash
rails console
user = User.find_by(email: "your@email.com")
user.update(role: "admin")
```
3. **Managing Servers:**
Admins: Go to /servers, add a server (Add Server), edit or delete via buttons.

Users: Use referral links to add servers to your list.

Switching Language:
Click "Українська" or "English" in the header to change the language.