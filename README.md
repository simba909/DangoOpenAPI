# OpenAPI generator sample app

This repository contains a minimal sample app that successfully builds for testing in Xcode
but fails to build using `xcodebuild` (and Xcode Cloud) on the command line.

**Update:** As of the last commit the project now builds successfully using both Xcode
and `xcodebuild`. The issue this sample was reproducing was a linker failure where the main
app target - rather than the unit testing target - needed to depend on the internal SPM 
package products.

## App structure
The app contains a single app target, a unit test target, and an internal SPM package
that vends two libraries; one depended on by the app target and the other depended on by
the unit test target.

Below is a diagram detailing the dependency graph between these targets:

```
       ┌───┐   ┌─────────┐
       │App│◀──│UnitTests│
       └───┘   └─────────┘
         │          │
         ▼          ▼
      ┌────┐   ┌─────────┐
      │Data│◀──│DataMocks│
      └────┘   └─────────┘
         │
         ▼
┌────────────────┐
│OpenAPIGenerator│
└────────────────┘
```

## Reproducing the issue

To reproduce the issue, clone the project and run the included `run_workflow.sh` script:
```
$ ./run_workflow.sh
```

This script will attempt to build the project for testing in a manner similar to that which
is used by Xcode Cloud. Using Xcode 15.2 / Swift 5.9.2 the script is likely to fail with the
following issue viewable from the result bundle (generated at
`<repo_dir>/workspace/resultbundle.xcresult`):

> Build input files cannot be found: '.../GeneratedSources/Types.swift',
> '.../GeneratedSources/Client.swift', '.../GeneratedSources/Server.swift'.
> Did you forget to declare these files as outputs of any script phases or custom build rules
> which produce them?
