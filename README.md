# Fresh Track 🥕
[![Made With](https://skillicons.dev/icons?i=swift)](https://skillicons.dev)  
## How to test Fresh Track
1. Clone the project
2. Open it in Xcode
3. Run a simulator

## Inspiration
Just in the United States 119 billion pounds of food is wasted yearly. Most food in the USA either has inaccurate food expiration labels or has no labels at all. Our app can improve the sustainability habits of its users and help them avoid incorrectly disposing of food that is perfectly fine. 

## What it does
An easy to use, AI powered expiration date tracker to help reduce food waste and food poisoning. Our app would remind users to utilize the food that is close to expiring and provide recipes to utilize the food.

## How we built it
We made the modern frontend using SwiftUI. We used GPT-3.5 to generate recipes that could be made using the present ingredients and a few additional APIs to automatically generate images.We trained our own CoreML models to calculate the expiry dates of foods Our CoreML model run 100 % locally and uses data from the United States Department of Agriculture, the U.S. Food & Drug Administration and the U.S. Centers for Disease Control and Prevention.

## Challenges we ran into
Since it was our first time building a legitimate application with SwiftUI, we struggled to get the Ml models working properly and integrating the numerous fragments of the UI to get it to function smoothly and efficiently. We also had trouble getting a proper dataset for our CoreMl model.

## Accomplishments that we're proud of
We were able to build a fully functional iOS app and integrate it with powerful machine learning tools. 

## What we learned
- **SwiftUI Mastery:** Since it was our first time using SwiftUI, we learnt a lot about how it works and its different capabilities.
- **Debugging Expertise:** Gained proficiency in debugging code, ensuring a seamless and bug-free user experience.
Integration Skills: We successfully integrated various components, making diverse elements work cohesively within the app.
- **Efficiency in Coding:** Explored new techniques to write efficient, optimized code, enhancing the overall performance of our app.
- **Machine Learning Experience:** We were introduced to CoreML, where we trained our own machine learning models and implemented them in our code.

## What's next for FreshTrack
We want to continue development of this app and add Camera functionality to it. Our ideas are to add barcode scanning, food detection, and mold detection. We also plan to publish the app on the iOS app store.
