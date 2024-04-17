# FitnessJournal

## Summary of Project
FitnessJournal is a weight loss tracking application designed to unite individuals on similar weight loss journeys. Inspired by the success of MyFitnessPal, FitnessJournal emphasizes collaboration and support in achieving weight loss goals. With 2.5 billion adults worldwide classified as overweight by the World Health Organization (WHO), effective weight loss tools are paramount. Research from the Centers for Disease Control and Prevention (CDC) demonstrates that working out with a friend increases motivation and consistency. FitnessJournal aims to harness this principle by offering personal food and exercise journaling, story posting, and journal matching options—all free of charge. FitnessJournal endeavors to contribute to a healthier world, one step at a time by providing a platform for mutual support and accountability.

## Project Proposal | Project Analysis

### Value Proposition
FitnessJournal addresses several pain points during the weight loss journey. First and foremost, the support and accountability. Many individuals struggle with weight loss due to a lack of support and accountability. FitnessJournal provides a platform for users to connect with others on similar journeys, offering mutual support and encouragement. The second pain point would be progress tracking. FitnessJournal simplifies the process of tracking food intake and exercise with its user-friendly interface and comprehensive tracking features (free of charge), enabling users to easily monitor their progress as this can be a tedious and overwhelming process. Last but not least, the importance of staying motivated and consistent. Maintaining motivation and being consistent is crucial for successful weight loss. FitnessJournal helps users stay motivated and committed by fostering a sense of community and facilitating collaboration. 

### Primary Purpose
The primary purpose of FitnessJournal is born from a personal need and a desire to address a common challenge in weight loss journeys. Initially conceived to benefit myself and a close circle of friends seeking to shed extra pounds, the genesis of FitnessJournal stems from frustration with existing apps' limitations, particularly the barriers imposed by "Freemium" models. Witnessing a friend struggle with the cumbersome process of manually tracking progress using a notepad further fueled the motivation to develop a solution that simplifies and streamlines the weight loss journey.

FitnessJournal aims to fill this gap by offering a comprehensive and user-friendly platform for tracking progress, meals, and exercise routines without the financial burden often associated with similar apps. By providing a free alternative to expensive subscription-based services, FitnessJournal seeks to empower individuals like myself and my friends to take control of their health and wellness journey, eliminating the need for makeshift tracking methods and promoting a more organized and effective approach to weight loss.

### Target Audience
FitnessJournal is tailored for young adults transitioning into adulthood, typically ranging from individuals in their late teens to those in their early 40s. This demographic is characterized by a shift in lifestyle priorities, often marked by the challenges of balancing work, social life, and personal health. Our target demographic details individuals who are actively seeking tools and resources to support their weight loss, individuals looking for practical solutions to improve their fitness levels and dietary habits, recent graduates/young professionals who have recently completed their education and are entering the workforce (facing new challenges in managing their time and health), people in their 30s and early 40s who juggle multiple responsibilities (career and family) who seek convenient solutions to maintain a balanced lifestyle. 

We aim at this demographic as we recognize the critical juncture in their lives where health and wellness may take a backseat among other priorities. By offering a user-friendly and accessible platform, FitnessJournal aims to empower young adults to take control of their health and fitness journey, facilitating long-term habits that promote a healthier lifestyle. 

Our outreach strategy primarily relies on word of mouth and organic growth, leveraging the strong network effect inherent in supportive communities. While we may explore targeted advertising methods to expand our reach, we prioritize providing value to our users without spamming them with intrusive advertisements, ensuring a positive user experience and fostering trust in our platform.

(Not to be rude, but the cutoff for the target audience is early 40s because I feel like that’s the cusp of people knowing how to leverage tech in their everyday lives, and targeting people beyond this age range would be significantly harder).

### Success Criteria
The ultimate success criteria for FitnessJournal is the tangible and sustainable weight loss achieved by the users. Ensuring that users are effectively and safely shedding excess weight is the ultimate measure of the app’s efficacy and impact. This will be assessed through the tracking of users’ weight loss progress, including changes in weight, dietary measures, and overall health metrics. Additional success criteria would be user engagement, satisfaction, growth of the app, etc. Although these metrics are important, they aren’t the primary goal in facilitating a meaningful weight loss journey/outcome for the users. We will be monitoring and evaluating the app state (accepting feedback through individual messaging, forums, emails, etc.), and will incorporate feedback accordingly, continuously assisting users on their journey.

### Competitor Analysis
FitnessJournal competes in a crowded market alongside established platforms such as MyFitnessPal, Noom, MyNetDiary, Lose It!, etc. These competitors offer comprehensive solutions for weight loss tracking, including features like food and exercise logging, goal setting, and community support. They benefit from strong brand recognition, extensive databases, and loyal user bases.

However, FitnessJournal aims to differentiate itself by offering a free, user-friendly alternative to subscription-based models. FitnessJournal seeks to attract users who prioritize affordability, accessibility, and effectiveness in their weight loss journey by focusing on simplicity, ease of use, and fostering a supportive community environment.

### Monetization Model
FitnessJournal implements an advertisement-based monetization model, offering all core features and functionalities free of charge to users. Users will be able to access essential tools for tracking their weight loss journey, setting goals, and engaging wit the community with any subscription fees or premium upgrades. The app will display non-intrusive advertisements strategically placed within the user interface, ensuring a seamless and uninterrupted user experience while generating revenue from advertising partners. Additionally, FitnessJournal may explore collaborations with health and wellness brands to offer sponsored content, promotional offers, equipment discounts, etc. further enhancing the app’s value proposition to users. 

(Maybe: donation model, affiliate model, discord nitro model).

## Initial Design
### Initial Mock-up
<img width="3052" alt="Initial Mockup" src="https://github.com/jcholol/FitnessJournal/assets/49222433/39fe61f0-bb4b-4056-a02f-134d4376a01b">

### UI/UX Design
Crucial UI
- (User registration, login)
- Dashboard (show daily progress)
- Food/Exercise Log
- Ability to search and add to each log
- (User settings, goal setting, etc)
- (Community engagement platform, messaging, posting, etc)
- (Support feature, user feedback)

### Technical Architecture
Necessary components/interactions
- List log of dates 
  - Register as a user (implies database, password encryption)
  - Add to log (implies storage)
- Search exercises or foods
  - Search algorithm/engine (implies some sort of indexing, database searching
- Select exercises or foods and store into a personal journal
  - Application component (implies UI, Swift, etc.).
  - Public API -> Provide the exercise and food ID
- Journal Matching? Story Posting? Messaging with matches?

Storage considerations? Probably a relational database like SQLite or maybe explore into some other data storage considerations like MySQL.

Web/cloud interactions? Maybe some AWS or GCP for cloud hosting

Minimum required navigational flow
- Show calorie details of today (yesterday and previous dates), food log, exercise log
  - Go to each log page for the desired day (food, exercise)
  - Add to log page for the desired day (food, exercise)

## Challenges and Open Questions
- Form Factor
  - Challenge: I want the users to have a certain orientation regardless of how they are holding their phone.
  - Solution: I put my application build setting so that the orientation does not change with the user's phone orientation. 
- Access/Usage of sensors
  - Challenge: Maybe a feature where the exercise can be put in automatically or suggest an exercise with a sensor.
  - Solution: Somehow detect the users in motion (exercising) by having a software sensor or a mixed sensor of both hardware and software.
- Resource constraints
  - Challenge: I'd like to have the application be able to work regardless of having internet but that might be a challenge as users might not have access to the database containing the food/exercise information offline.
  - Solution: Maybe have the ability to jot down whatever they are doing and sync it up to the database later without the user having to do it manually later. 
- Permissions/Capabilities
  - Challenge: Since we will be tracking a lot of personal data regarding a user's health, privacy will become an issue at some point.
  - Solution: Thus, I will need to carefully read all of the necessary permissions and implement the permission settings regarding why we need some specific information and let the user know the reasoning before collecting the data. 
