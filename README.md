# ResurrectAI Project Documentation

## Overview

ResurrectAI is a project designed to bring great historical personalities to life through their wisdom by creating a chat application where users can interact with these personalities and seek guidance on almost any topic. The app functions as a 24/7 buddy offering advice in various situations.

### Important Note
- **Linux Machine Required**: The Flask app (`app.py`) requires a Linux machine to run.
- **Alternative**: If you do not have access to a Linux machine, you can try out the code using the training and inference Jupyter notebooks provided in the repository.

## Project Structure

- **app.py**: Flask application to run and interact with the AI model.
- **ResurrectAI_Training.ipynb**: Jupyter notebook for training the AI model.
- **ResurrectAI_Inference.ipynb**: Jupyter notebook for running inference with the AI model.
- **Audio/**: Directory containing audio resources.
- **Books/**: Directory containing text resources.
- **static/styles/**: CSS and styling files for the frontend.
- **templates/**: HTML templates for the web interface.
- **README.md**: Project documentation.
- **requirements.txt**: List of dependencies required to run the project.
- **mobile/resurrectai/**: Flutter app files (not yet connected to the AI model).
- **static/screenshots/**: Directory containing screenshots for documentation.

## Setup Instructions

### 1. Environment Setup

#### Prerequisites
- **Python 3.x**: Ensure that Python 3 is installed on your system.
- **Linux Machine**: Required for running the Flask app (`app.py`).

#### Step-by-Step Guide

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/resurrectai.git
   cd resurrectai
   ```

2. **Create a Virtual Environment**:
   ```bash
   python3 -m venv venv
   source venv/bin/activate  # Linux
   ```

3. **Install Dependencies**:
   Install the required packages using the `requirements.txt` file:
   ```bash
   pip install -r requirements.txt
   ```

4. **Install Unsloth and Additional Libraries**:
   Run the following commands to install Unsloth and other dependencies required for both the Flask app and the Jupyter notebooks:
   ```bash
   pip install "unsloth[colab-new] @ git+https://github.com/unslothai/unsloth.git"
   pip install --no-deps xformers trl peft accelerate bitsandbytes triton
   ```

### 2. Running the Flask App (`app.py`)

1. **Start the Flask Application**:
   ```bash
   python app.py
   ```

2. **Access the Web Interface**:
   Once the application is running, open your browser and navigate to `http://localhost:5000` to interact with the AI model.

   ![Screenshot of Flask App](static/screenshots/flask_app.png)  
   *Example: Screenshot showing the ResurrectAI web interface.*

### 3. Alternative for Non-Linux Users

If you do not have a Linux machine, you can use the provided Jupyter notebooks:

1. **Training the Model**:  
   Open the `ResurrectAI_Training.ipynb` notebook in Jupyter and follow the steps to train the AI model.

   ![Screenshot of Training Notebook](static/screenshots/training_notebook.png)  
   *Example: Screenshot showing the training process in Jupyter.*

2. **Running Inference**:  
   Use the `ResurrectAI_Inference.ipynb` notebook to run inference and interact with the model in a non-Linux environment.

   ![Screenshot of Inference Notebook](static/screenshots/inference_notebook.png)  
   *Example: Screenshot showing the inference process in Jupyter.*

### 4. Connecting Firebase to the Flutter Application

To allow users to download and use the ResurrectAI Flutter app with their own Firebase project, follow these steps:

1. **Set up a Firebase Project**:  
   - Go to the [Firebase Console](https://console.firebase.google.com/) and create a new project.
   - Follow the setup instructions for Firebase, and make sure to add your Android/iOS app to the Firebase project.

2. **Modify `google-services.json` (Android)** or `GoogleService-Info.plist` (iOS):
   - After setting up Firebase, download the `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS) file from your Firebase console.
   - Place this file in the respective directories in your Flutter app:  
     - `android/app/` for Android (`google-services.json`)
     - `ios/Runner/` for iOS (`GoogleService-Info.plist`)

3. **Install Firebase SDK**:
   Ensure you have the necessary Firebase packages installed in your Flutter project by following the official Firebase documentation for Flutter: [Firebase for Flutter](https://firebase.google.com/docs/flutter/setup?platform=android).

   ```bash
   flutter pub add firebase_core
   flutter pub add firebase_auth
   # Add other Firebase packages as needed
   ```

4. **Initialize Firebase in Flutter**:
   In your `main.dart`, initialize Firebase before running the app:
   ```dart
   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp();
     runApp(MyApp());
   }
   ```

   ![Screenshot of Firebase Setup](static/screenshots/firebase_setup.png)  
   *Example: Screenshot showing Firebase setup in Flutter.*

### 5. Flutter Application

The Flutter application is developed but not yet connected to the AI model for interactivity. Once connected, instructions for using the mobile app will be provided in future updates.

## Screenshots

To assist users with setting up and using the project, screenshots have been included in the `static/screenshots/` directory. Below are some key examples:

- **Flask App Interface**: `static/screenshots/flask_app.png`
- **Training Notebook**: `static/screenshots/training_notebook.png`
- **Inference Notebook**: `static/screenshots/inference_notebook.png`
- **Firebase Setup in Flutter**: `static/screenshots/firebase_setup.png`

## Contributing

If you'd like to contribute to ResurrectAI, feel free to fork the repository, make your changes, and submit a pull request. Ensure that your code adheres to the project’s coding standards.

## Future Work

- **Connecting Flutter App**: The next step is to connect the Flutter application to the AI model for full interactivity.
- **Cross-Platform Support**: Plans are in place to make the Flask app cross-platform to support non-Linux environments.

## Contact

For any queries or support, please contact [your email] or open an issue in the repository.
