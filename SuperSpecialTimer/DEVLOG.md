#  Super Special Timer DevLog

## july 1, 2024
Happy Canada Day!!
For handling text fields:
https://chatgpt.com/share/2f1c375f-99c8-42ac-9946-609616244b69

TODOS FOR CANADA DAY (FORM CITTYYY)
- [ ] Get the theme colours on another page
- [ ] Text field behaves properly
    - [ ] On editingDidStart, empty the field
    - [ ] On editingDidEnd, revert to original value if empty
- [ ] Picker wheel of integers to infinity for # of rounds
- [ ] Picker wheel of <x>mins<y>secs for work/rest duration


## June 25, 2024
view dismiss itself so after form submission we back to homepage
https://www.hackingwithswift.com/quick-start/swiftui/how-to-make-a-view-dismiss-itself

Helpful for the forms:
https://serialcoder.dev/text-tutorials/swiftui/creating-forms-in-swiftui/

User Defaults bs:
https://stackoverflow.com/questions/55815451/saving-an-array-of-structs-to-userdefaults
https://stackoverflow.com/questions/63166706/how-to-store-nested-arrays-in-appstorage-for-swiftui

Card view:
https://dev.to/kafran/swiftui-list-card-view-2da4

How do we store the timers?

ideal:
["TITLE 12 20 30", "TITLE2 30 10 30"]

other ideas:
"TITLE 12 20 30 || TITLE2 30 10 30 || TITLE3 60 32 22"
then manually parse it. ew.
