# SwiftGen Cache

Hi Guys!

SwiftGen has a problem with performance when the 'Assets' are large.
I was very angry when my project rebuilds every time. 
I have discovered that Swiftgen re-generates files which lead xcode to rebuild it’s cache.
I made a tool to help with this problem.

The tool produces a file SwiftGen.lock. 
This file has a hash of every file registered in SwiftGen.
Next time when you build a project, this tool will create a temporary file SwiftGen.lock.tmp that is a copy of SwiftGen.tmp including hashes of the new files.

If hashes of corresponding files are not equal in SwiftGen.lock.tmp and SwiftGen.lock, the tool is going to return “true” which means that you need to execute SwiftGen.
This tool can work with Assets and Localisation. If you need other tools and utilities, contact me.

## Installation

```
gem install CheckSwiftGen
```

You must pass two args
1) Path by swiftgen.yml
2) Path where SwiftGen will made

```
swiftgen_check_for_new ./swiftgen.yml .
```


## Intergration in Xсode with cocoapods
1) Select “New Run Script Phase” in Build Phases
2) Insert '/bin/bash' -l into Shell
3) Paste this script

```
check=$(swiftgen_check_for_new "${PROJECT_DIR}/swiftgen.yml" "${PROJECT_DIR}")
if $check == true
then
${PODS_ROOT}/SwiftGen/bin/swiftgen config run --config ${PROJECT_DIR}/swiftgen.yml
fi
```

![image](https://user-images.githubusercontent.com/1247906/128891065-463064ca-400e-40dc-9674-87e105a3dc55.png)
