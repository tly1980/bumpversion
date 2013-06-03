# bumpversion

Bump the version to a json file (VERSION.json)

## Getting Started
Install the module with: `npm install bumpversion`

After the installation, you can run
```shell
$ bumpversion -m v0.1.1 -c 1
```

And it would return would something like 
```
version bumped to:
 {
    "cache": 1,
    "timestamp": "2013-06-03T03:57:17.273Z",
    "main": "v0.1.1"
}
```
Meanwhile, a file named VERSION.json would be created with same content.

## VERSION.json

* main 
  A string field, indicating the main version. Could be something like "release/v1.2.3"
* cache
  A integer field indicating the cache version. A good usercase of this field is CDN versioning.
  If you do not specify "-c", this field would be self increment.
* timestamp
  A GMT timestamp indicating when the file being generated.
* last_commits
  If you are using git, you can call bumpversion -lc 3, it would include last three commits version hash and log message  into last_commits.


## Examples
If you execute "bumpversion" inside a git repository without specifying "-m", it will automatically take the branch name as main version.

### Take git branch as main version.
Now I am inside a git repository:
```shell
$ git branch
  develop
  master
* release/0.1.1
```

Now execute "bumpversion"
```shell
$ bumpversion
version bumped to:
 {
    "cache": 5,
    "timestamp": "2013-06-03T03:53:55.972Z",
    "main": "release/0.1.1"
}
```

### Include the last N GIT commit hash / log into VERSION.json
Including last 2 commits
```
bumpversion -lc 2
version bumped to:
 {
    "cache": 2,
    "timestamp": "2013-06-03T04:16:18.487Z",
    "main": "release/0.1.1",
    "last_commits": [
        "0f0ef3da436f5f5f71dcbf78ce720bcd2ff47e7e version bumped",
        "a9b14b2ee13a532534d8e75e0e83192534cbd8cc Merge branch 'release/0.1' into develop"
    ]
}
```

Including last 5 commits
```
bumpversion -lc 5
version bumped to:
 {
    "cache": 3,
    "timestamp": "2013-06-03T04:19:07.317Z",
    "main": "release/0.1.1",
    "last_commits": [
        "0f0ef3da436f5f5f71dcbf78ce720bcd2ff47e7e version bumped",
        "a9b14b2ee13a532534d8e75e0e83192534cbd8cc Merge branch 'release/0.1' into develop",
        "82f901f53fe61fc469c869a5da009aaec26d4b06 include the test",
        "73a5c11f9675f67556ad691f023255761568bf97 misc changes",
        "83c4c440ac4b47fc0d6fbb5f5b84339889e0e075 add package.json"
    ]
}
```

### Semantic version conversion
bumpversion supports very basic [Semantic Version](http://semver.org/) convertion.



For example, current branch is "release/0.1.3", if you add "-s", main version would be converted to "0.1.3"

```
bumpversion -s
```

Output

```
VERSION_PATH /Users/minddriven/workspace/bumpversion/VERSION.json
version bumped to:
{
    "cache": 7,
    "timestamp": "2013-06-03T05:45:41.422Z",
    "main": "0.1.3"
}
 and save to : /Users/minddriven/workspace/bumpversion/VERSION.json
```

More information about [Semantic Version](http://semver.org/)

### Update the package.json.

```
bumpversion  -s -p
VERSION_PATH /Users/minddriven/workspace/bumpversion/VERSION.json
version bumped to:
{
    "cache": 8,
    "timestamp": "2013-06-03T05:48:37.756Z",
    "main": "0.1.3"
}
 and save to : /Users/minddriven/workspace/bumpversion/VERSION.json
package.json is also being updated with version: 0.1.3
```
_Notes:_
It is always recommand to use -p with -s. In the next version, -p would implies -s.


## Usage
Displaying the help

```shell
$> bumpversion -h
```

```
usage: bumpversion [-h] [-v] [-m M] [-c C] [-q] [-lc LC] [-f F] [-x X] [-p]
                   [-s]


A tool to generate / bump the version to a JSON file.

Optional arguments:
  -h, --help     Show this help message and exit.
  -v, --version  Show program's version number and exit.
  -m M           Update the main version. If you do not specify version
                 number, Main version will be take it as git branch by
                 default.
  -c C           Update the cache version. If you not specify version number,
                 it would be a self increment number
  -q             quiet mode.
  -lc LC         Update the last default commit
  -f F           The file to store JSON
  -x X           Exclude the fields to be updated. Could be "m", "c" or "mc".
  -p             Update the VERSION to package.json.
  -s             Semantic version conversion.
```

## Best Practice ##
bumpversion is particular useful when you use it with git flow / hubflow.
You can call bumpversion -lc 2 every time you are about to close your release or hotfix branch, namely (git flow release finish / git flow hotfix finish).
It would automatically record take the branch name as main version and include the last commits log into VERSION.json.


## Release History
_(Nothing yet)_

## License
Copyright (c) 2012 Tom Tang  
Licensed under the BSD license.
