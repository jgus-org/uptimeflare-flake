# uptimeflare

A Nix flake pinning the upstream source of [UptimeFlare](https://github.com/lyc8503/UptimeFlare), a status page that runs on Cloudflare Workers.

## Artifact

`packages.default`: the upstream source tree at the pinned commit, as fetched by `fetchFromGitHub`. Nothing is built here. The flake pins and verifies source, and the consumer runs UptimeFlare's own build.

## Consuming

```nix
src = uptimeflare.packages.${system}.src;
```

## What you get

- The pin tracks commits rather than releases, so `version` is a date (`0-unstable-YYYY-MM-DD`) and `sourceRev` records the commit it resolves to.
- UptimeFlare deploys as a Cloudflare Worker plus a Pages site, and its own build needs Node, `npm install`, `wrangler`, `next-on-pages`, and the upstream Terraform configuration. None of that is supplied here.
- The output is a read-only store path. A build that writes into the tree (`npm install`, or substituting a generated `uptime.config.ts`) needs a writable copy of it first.

See [LICENSE.md](LICENSE.md) for licensing and copyright, and [NOTICE.md](NOTICE.md) for the terms of upstream and distributed artifacts.
