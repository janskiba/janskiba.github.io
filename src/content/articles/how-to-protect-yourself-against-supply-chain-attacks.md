---
title: "How to protect yourself against supply chain attacks"
summary: "Supply chain attacks keep happening. Here's what they are and two simple things you can do to reduce the risk."
publishedAt: 2026-06-14
---

## Another day, another supply chain attack...

Supply chain attacks have become an increasingly common threat in modern software development. Over the past few years, developers and organizations have repeatedly seen trusted tools, libraries, and package ecosystems abused as a way to compromise downstream users.

A few notable examples include:

- TanStack
- Axios
- Bitwarden CLI

These incidents highlight a difficult reality: even teams that follow good security practices can still be exposed when they rely on compromised third-party dependencies.

## What is supply chain attack

A supply chain attack happens when an attacker compromises software before it reaches the end user. In practice, this often means publishing a malicious version of a package to an official repository, hijacking a maintainer account, or injecting harmful code into a build or release pipeline.

Because developers and CI systems often trust official package registries and automated updates, malicious versions can spread quickly. Once installed, they may steal secrets, API tokens, credentials, or cryptographic keys. In more advanced cases, they can also open backdoors, modify application behavior, or move deeper into an organization’s infrastructure.

## How to protect yourself against supply chain attacks

### Set min release date in your package manager

One practical way to reduce the risk of installing a malicious package version is to avoid adopting newly published releases immediately.

Many supply chain attacks rely on a short time window: an attacker publishes a malicious version, some users and CI pipelines install it right away, and only later the package is reported, investigated, and removed. If your package manager is configured to install only versions older than a certain threshold — for example, one week — you significantly reduce the chance of pulling a compromised release.

This approach will not eliminate the risk entirely, but it adds a useful delay layer. In many real-world cases, malicious versions are discovered and removed within hours or days, long before they become eligible for installation in your environment.

#### npm

In `.npmrc`

```
min-release-age=7 # in days
```

https://docs.npmjs.com/cli/v11/using-npm/config#min-release-age

#### Yarn

In `.yarnrc.yml`

```
npmMinimalAgeGate: "1w"
```

https://yarnpkg.com/configuration/yarnrc#npmMinimalAgeGate

#### pnpm

In `pnpm-workspace.yaml`

```
minimumReleaseAge: 1440 #number of minutes
```

https://pnpm.io/settings#minimumreleaseage

#### Bun

In `bunfig.toml`

```
# Only install package versions published at least 3 days ago
minimumReleaseAge = 259200 # seconds

# Exclude trusted packages from the age gate
minimumReleaseAgeExcludes = ["@types/node", "typescript"]
```

https://bun.com/docs/pm/cli/install#minimum-release-age

### Use lockfiles

`package-lock.json` is overwritten when dependencies are intentionally added, updated, or re-resolved. When installing a repository for the first time, prefer `npm ci` over `npm install` if the lockfile already exists, because it respects the exact locked versions and reduces the risk of unexpected dependency changes.

## Summary

Two simple things: set a minimum release age in your package manager, and use lockfiles. Neither guarantees safety, but both make it harder to get hit.
