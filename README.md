# SwiftGen Cache

Hi Guys & Girls
The Swiftgen have been problem with performance when the 'Assets' are large
I was very angry when my project rebuild build every one. I understood what swiftgen generate files every time then xcode rebuild cache

I make tool for help with this problem.

The tool make the file SwiftGen.lock. The file has hash every one file from which was generate 'Swift code'.

When next time you build project, the tool make temp file SwiftGen.lock.tmp which made like SwiftGen.lock but with hash with new files

if hash by SwiftGen.lock.tmp is not equal hash by SwiftGen.lock then the tools return 'true' and you need to call SwiftGen

This tool could work with Assets and Localisation.
If you need other resource, write to me.



## Installation

```
gem install CheckSwiftGen

You must pass two args
1) Path by swiftgen.yml
2) Path where SwiftGen will made
swiftgen_check_for_new ./swiftgen.yml .
```


## Intergration with XCode and cocoapods
1) You have to make script in Build Phases.
2) You have to change shell by '/bin/bash -l'
3) The paste this script in the phase

```
check=$(swiftgen_check_for_new "${PROJECT_DIR}/swiftgen.yml" "${PROJECT_DIR}")
if $check == true
then
${PODS_ROOT}/SwiftGen/bin/swiftgen config run --config ${PROJECT_DIR}/swiftgen.yml
fi
```
