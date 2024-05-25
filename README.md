<p align="center">
  <img src="https://github.com/muratalbayrak00/My-Dictionary/assets/95575668/ff9c1d17-78af-4430-9725-99dcc8529092" alt="Getir Lite App Icon" width="150" height="150">
</p>

<div align="center">
  <h1>My-Dictionary - Turkcell GYGY Final Project by Murat Albayrak</h1>
</div>

Welcome to the My Dictionary App! This app allows users to search for English words, view their meanings, see recent search history and synonyms.

## Table of Contents
- [Features](#features)
  - [Screenshots](#screenshots)
  - [Tech Stack](#tech-stack)
  - [Architecture](#architecture)
  - [Unit Tests](#unit-tests)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)


## Features

 **Search for Words:**
- Users can search for English words using a search bar.
- Displays the last 5 searches below the search bar.
- Tapping on a recent search takes the user to the word's detail page.
- Users can navigate to the detail page by entering a word and tapping the "Search" button.

 **Word Details:**
- Displays the definitions of the searched word.
- Shows the top 5 synonyms of the word based on their scores.

 ## Screenshots

| Image 1                | Image 2                | 
|------------------------|------------------------|
| ![Listing1](https://github.com/muratalbayrak00/My-Dictionary/assets/95575668/f39070e1-4f03-449f-80fc-4438f5fb7a9a) | ![Listing2](https://github.com/muratalbayrak00/My-Dictionary/assets/95575668/cbe0a724-7cb8-4b5a-8e8f-5c0b21da10fe)


## Tech Stack

- **Xcode:** Version 15.2
- **Language:** Swift 5.9.2
- **Minimum iOS Version:** 13.0
- **Dependency Manager:** SPM

This project uses the VIPER (View-Interactor-Presenter-Entity-Router) architecture for the following reasons:

- **Clear Separation:** VIPER separates UI, business logic, and navigation for cleaner, more maintainable code.
- **Test-Driven Development:** VIPER's modular structure enables comprehensive unit testing, ensuring app stability.
- **Scalability:** VIPER's modular design allows easy addition of features and modifications.

### Unit Tests

- Presenters and interactors for each module
- SearchService
- Networking components

## Getting Started

### Prerequisites

Before you begin, ensure you have the following:

- Xcode installed

Add the following dependencies in your project's target:

- [Alamofire]([https://github.com/onevcat/Kingfisher](https://github.com/Alamofire/Alamofire)): 

### Installation

1. Clone the repository:

    ```bash
    git clone [https://github.com/yourusername/YourProject.git](https://github.com/muratalbayrak00/My-Dictionary)
    ```

2. Open the project in Xcode:

    ```bash
    cd My-Dictionary
    open MyDictionaryModular.xcworkspace
    ```

3. Add required dependencies using Swift Package Manager:

   ```bash
   - Alamofire
    ```

4. Build and run the project.
