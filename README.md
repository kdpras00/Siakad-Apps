# SIAKAD Apps

## Initial Setup and Installation

### Prerequisites
- Git installed on your system
- GitHub account
- Node.js (if this is a Node.js project)
- Any other project-specific dependencies

### Clone the Repository
To get started with the SIAKAD Apps project, you'll need to clone the repository to your local machine.

1. Open your terminal or command prompt
2. Navigate to the directory where you want to store the project
3. Run the following command:

git clone https://github.com/kdpras00/siakad_apps.git

4. Navigate into the project directory:

cd siakad_apps

### Install Dependencies
After cloning the repository, install the necessary dependencies:

npm install
or if you're using yarn:
yarn install

### Configure Environment Variables
Create a `.env` file in the root directory and configure the necessary environment variables. You can copy the `.env.example` file if it exists:

cp .env.example .env

Then edit the `.env` file with your specific configuration.

### Run the Application
Once everything is set up, you can run the application locally:

npm start
or for development mode:
npm run dev

### Pushing Changes to GitHub
When you make changes and want to push them to GitHub:

1. Add your changes:
git add .

2. Commit your changes:
git commit -m "Your descriptive commit message"

3. Push to GitHub:
git push origin main
