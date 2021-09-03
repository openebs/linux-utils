# linux-utils

This repository contains the scripts required for building a customized alpine based linux utils docker image used for launching OpenEBS helper jobs. 
This repository also acts as a trigger to initiate the release workflow. For example: 
- Creating a release tag from `main` branch with a release tag like v3.m.n, will result in tagging the downstream repos with the tag v3.m.n on branch v3.m.x
- Creating a release tag from `v2.12.x` branch with a release tag like v2.12.1, will result in tagging the downstream repos with tag v2.12.1 on branches v2.12.x

For more information on the release process, see https://github.com/openebs/openebs/blob/HEAD/RELEASE.md
