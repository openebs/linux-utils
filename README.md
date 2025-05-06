# linux-utils
[![CI](https://github.com/openebs/linux-utils/actions/workflows/pull_request.yml/badge.svg)](https://github.com/openebs/linux-utils/actions/workflows/pull_request.yml)
[![Slack](https://img.shields.io/badge/chat-slack-ff1493.svg?style=flat-square)](https://kubernetes.slack.com/messages/openebs)
[![Community Meetings](https://img.shields.io/badge/Community-Meetings-blue)](https://github.com/openebs/community/blob/HEAD/README.md#community)
[![FOSSA Status](https://app.fossa.com/api/projects/custom%2B162%2Fgithub.com%2Fopenebs%2Flinux-utils.svg?type=shield&issueType=license)](https://app.fossa.com/projects/custom%2B162%2Fgithub.com%2Fopenebs%2Flinux-utils?ref=badge_shield&issueType=license)

This repository contains the scripts required for building a customized alpine based linux utils docker image used for launching OpenEBS helper jobs. 
This repository also acts as a trigger to initiate the release workflow. For example: 
- Creating a release tag from `main` branch with a release tag like v3.m.n, will result in tagging the downstream repos with the tag v3.m.n on branch v3.m.x
- Creating a release tag from `v2.12.x` branch with a release tag like v2.12.1, will result in tagging the downstream repos with tag v2.12.1 on branches v2.12.x

For more information on the release process, see https://github.com/openebs/openebs/blob/HEAD/RELEASE.md

## License Compliance
[![FOSSA Status](https://app.fossa.com/api/projects/custom%2B162%2Fgithub.com%2Fopenebs%2Flinux-utils.svg?type=large&issueType=license)](https://app.fossa.com/projects/custom%2B162%2Fgithub.com%2Fopenebs%2Flinux-utils?ref=badge_large&issueType=license)
