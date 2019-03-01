# verb-dev-update
Updates to serfs do not change a version number. A version number only addresses the rest of the framework or file structure other than serfs.
DEV version numbers have an extra digit and never end in 0, skipping it. This reserves the final number of the stable channel for vital patches.
eg:
stable version: 1.04.0 (main release), 1.04.1 (vital update, no new features), 1.04.2 (vital update, no new features)
develp version: 1.04.19, (NEVER 1.04.20), 1.04.21, 1.04.22

