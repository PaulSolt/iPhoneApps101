# Protect API Keys on Public Repositories

You will need an API key to get real weather data. Follow the steps below to get credentials so you can make a weather request.

This project is hosted in a public repository, so I have created a build script that will copy a Secret.swift file into the project, which will be ignored from version control. You'll need to edit the file to make your API requests succeed.

## Get an API Key from OpenWeather

1. Create an account: https://home.openweathermap.org/users/sign_up
2. Copy your key from API Keys to the `apiKey` variable in "Secret.swift": https://home.openweathermap.org/api_keys
3. NOTE: Don't commit "Secret.swift" publicly on Github (See below)

## Why All the Secrecy?

If you commit an API key to a public repository there are bots that will email you about it. And there are other bots that are looking for API keys, which might exaust your API key. Some other entity might use all your daily API calls in seconds.

To prevent this, we are copying in a template into the project using a Run Script before we compile the code. You need to edit the variable in Secret.swift with your key.

### .gitignore

I have the Secret.swift file ignored from git, which means it should not get commited to Github (unless you change the file name).

The hidden file .gitignore allows us to ignore certain files on Github. You cannot see hidden files by default when looking in Finder, but you can in Xcode or Terminal.

If you're paying for API access, you could unknowingly rack up a huge bill because other maliocious bots or people start using your key.

### Private Github Repositories

If your Github repository is private then this is not a problem, but it becomes a problem if you decide to make it open source.
