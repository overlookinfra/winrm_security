# winrm_security

#### Table of Contents

1. [Description](#description)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Limitations - OS compatibility, etc.](#limitations)
4. [Development - Guide for contributing to the module](#development)

## Description

This module provides task for interacting with WinRM and securing its configuration.

## Usage

#### Example: Fetching WinRM Listeners

```
bolt task run winrm_security::fetch_listeners --targets windowsnode01
```
#### Example: Configure a WinRM HTTPS Listener

```
bolt task run winrm_security::configure_https_listener --targets windowsnode01
```

## Limitations

In the Limitations section, list any incompatibilities, known issues, or other warnings.

## Development

In the Development section, tell other users the ground rules for contributing to your project and how they should submit their work.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You can also add any additional sections you feel are necessary or important to include here. Please use the `## ` header.
