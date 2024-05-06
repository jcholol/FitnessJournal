## The various states that an app can enter on your platform of choice
- App not running state
  - the app is not running/launched.
- App inactive/foreground state
  - The app is running in the foreground but is currently inactive. (Phone call interruption, locked the screen while using, using another app, etc).
- App active/using state
  - The app is running in the foreground and is current being used.
- App background state
  - The app is running in the background and not visible on the screen and not in the foreground. (running another app, home screen)
- App suspended state
  - The app is still stored in memory but not executing anything (switched to another app).
- App terminated state
  - The app is terminated (swiped it off your screen).

## The various states that you must consider for your app, why you must consider it, and what must happen in each state.

- Error state
  - Handle Errors and display them properly to the user to notify what went wrong
    - Display error messages
    - Allow user to send log/reports/feedback
    - Implement crash analytics to fix the crashing bug 
- Update state
  - Future release/bug states
    - Provide patch notes
    - Install updates in the background
    - Tell users to update their app
- Data sync state
  - Sync user data to the server (storing locally stored info into the cloud)
    - Abstract the syncing information from the user (have the syncing happen in the background)
    - Handle errors during syncing 
- Exercise completed state
  - User finishes a routine
    - Provide proper feedback (different colors for progress rates)
    - Display congrats message for meeting goals or staying consistent
    - Share routine/progress with other users
- Paused state
  - User stops tracking their food/activity
    - Paused state (handled by UI)
    - Will not save if the app is terminated mid type? Maybe store it locally and then store it into the cloud -> removing the locally stored data after a certain amount of time
- Tracking state
  - User is actively logging/tracking their routine/food intake
    - Allow useres to log their workouts and food
    - Update user progress and maybe some sort of audio/media playback that helps confirm the completeness of activity
- Idle state
  - App is not being used but running in the background
    - If I get my application to utilize the iPhone's health app, track their movements through sensors (might be out of my scope for now)
    - Data syncing during this time period
    - Persist tombstone data for a certain period of time (if user has typed something but has moved away for a bit)

    
