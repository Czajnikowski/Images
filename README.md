# Images - a demo project that I prepared for LiveSurface.

I'd say that the most appropriate pattern to SwiftUI and Combine is some kind of Redux or TCA, but due to extreme time limitations (8 hours max for the whole app!) and the amount of experience that I have with these, I've decided to choose MVVM+C.

When it comes to architecture I think that the most valuable thing is to have a clear separation between the user interface and underlying logic and services. I decided to implement the UI in a separate, leaf framework that is wired in the main app target. Every screen of the app (`ImagesView`, `EditorView`) is decoupled from the rest of the UI by the usage of builders. 

Some shortcuts I've taken:
- on Mac you'll get just a `VStack` - `LazyVGrid` will be available in Big Sur
- navigation is the same for both platforms
- I'm displaying just name of the image as a metadata
- when it comes to transforming image in the editor I'm applying just a single filter or none at all
- no cool-looking design at all
- no tests, sorry...

There are plenty of things that could have been done better, some pieces of code are pretty chaotic and some will be easy to resolve when Big Sur will come out. I'm keen to discuss them in the next phase of the interview process.

Thanks for inviting me to the challenge!
