# PIP/Expand Video Demo
This project is a demo for showing a pip mode video play with remote video URL.
## Table of Contents

- [Introduction](#introduction)
- [Demo Video](#demo-video)
- [Tools and Technologies](#tools-and-technologies)
- [Project Structure](#project-structure)
- [Usage](#usage)

## Introduction
This project is a demo for showing a pip mode video play with remote video URL. It is designed considering requirements in mind such as maintaining pip and expanded mode for both landscape and portrait mode.

## Demo Video

You can find demo video of app working below.

[Demo Video](https://drive.google.com/file/d/1QZxXT3bfsXHYlZQCzKMKdKlytBmDzebW/view)

### Main Features
- Video Player with remote URL.
- Aspect ratio maintained in landscape and portrait mode.
- Aspect ratio is maintained in pip and expanded mode.

## Tools and Technologies

List of tools and technologies used in this project.

- **Xcode**: Version 15.1
- **Programming Language**: Swift
- **UIKit**
- **AVPlayerController and AVPlayer**
- **MVVM**

## Project Structure

Project structure is as follows:
- SceneDelegate -> It has entry point of the app. You can change the URL of the video here.
- VideoInVideoController -> It has presentation of AVPlayer and AVPlayerViewController with both video modes(Pip, Expand)
- VideoInVideoViewModel -> Business logic implemented here
  
## Usage

Provide instructions on how to set up and run your project. Include any configuration steps or prerequisites.

1. Clone the repository: `git clone https://github.com/irfaniOSdev/VideoInVideo.git`
2. Open the project in Xcode.
3. Run the project on simulator or a physical device.
4. Video will automatically stream in expanded mode after LaunchScreen.
