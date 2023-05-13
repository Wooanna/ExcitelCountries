# ExcitelCountries
Simple structure of the app

- Extendable networking layer
- Used MVVM pattern for the presentation layer
- Added a few unit tests


Updated the image urls to .png from .svg files, because .svg is not supported by iOS, we would 
need to depend on external libraries in order to render .svg, so I choose not to. Instead I download .png files. 
I hope the .svg was not mendatory to use.

Things we could do further depending on requirements:
- Localization
- Have image in-memory caching, so we do not fetch every time, and have data offline, etc.
- ...
