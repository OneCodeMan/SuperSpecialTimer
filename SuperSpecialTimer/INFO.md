#  DEVLOG

## I DON'T THINK THEY RUNNING AT MY PACE. JORDAN 1'S -- GOTTA KEEP THEM LACED.


## November 3, 2024 [[[[October 31, 2024]]]]

### WAVE 1.1
- [ ] Basic `TimerStats`
    - [ ] If user did not terminate, record the session.
    - [ ] User stats of how many times they have used timer and when.
- [ ] On `TimerDetailView`, add an indicator on state.
    - Whether it's paused or not mainly.
..
- [ ] Design the different types of timers.
    - 3 types:
        1. basic (work; no rest, no break) (oven, etc.)
        2. pomodoro (work & break) (others: martial arts sparring/drilling rounds)
        3. HIIT (work & rest & break)
..                                                                                                                           
- [ ] Style the List view
- [ ] Perfect the Detail view.
- [ ] Style the Onboarding View
..
- [ ] Create app logo
- [ ] Create launch screen

.......................................................................................

# HISTORY

## November 5, 2024
- [x] Create a `postTimerSummary` view
- [x] `TimerInfoView` does not display updated data.
    - probably displays placeholder or outdated data.
     - no it was dumber than that. global vars that were supposed to just be examples affecting shit.

## November 4, 2024
- [x] Create `OnboardingView`
- [x] Stop button tapped when timer is active: "Are you sure you want to stop?"
    - [x] Then: "Conclude session?" "Cancel session?"
- [x] Hide the back button on timer active state.
- [x] Timer can repeat after stopped.

## November 2-3, 2024
- [x] Have a detailsview with a button to a countdown view which segues to finally run the timer.
- [x] Implement `CountdownView`
- [x] In the `TimerData` or somewhere in viewmodel, have vars responsible for displaying parsed data.
    - We are parsing data in the Views themselves, we shouldn't.
- [x] Make the timer repeat depending on rounds set.


............................................................

## October 30, 2024
MVP state from now:
- [ ] Display ListView items properly
- [ ] Display DetailView items properly
- [ ] Add audio

## UPDATE ON PROJECT -- October 29, 2024
I am currently working on finishing up the MVP for Pinselton. I will give this
more attention when I have gotten Pinselton to app store state.

## TODOS -- June 22, 2024
- [x] User can edit a timer and save to user defaults
- [x] User can delete a timer
- [ ] Do something about default timers.

Later TODOs:
- Smooth user flow
- Different Layouts
















....

## Notes
- Focused on the artistic/design side. The user experience side. The juice.
...

- Consider HIIT timers and Pomodoro timers.
- Consider the option of having unlimited rounds.

### TODOs -- May 8, 2024
- [x] Parse the seconds into minutes and seconds... 
    - "1:34", "10:34", "10:03"
### June 9, 2024
- [ ] Create "Add/Edit Timer Form"
- [ ] Implement user defaults

### On Deck
- [ ] Design a system
- [ ] 

...

## MID GAME
- Add sound

    

## LATE GAME
- Add themes
