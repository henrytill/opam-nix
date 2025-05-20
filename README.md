# `opam-nix`

Turn opam-based OCaml projects into [Nix](https://nixos.org) derivations,
automatically resolving both OCaml and system dependencies.

`opam-nix` can build packages

- from [`opam`](./DOCUMENTATION.md#buildOpamProject) and [`dune-project`](./DOCUMENTATION.md#buildDuneProject) files,
- for Linux and macOS,
- on x86_64 and aarch64 (including M1 macs),
- using a compiler from [nixpkgs](https://github.com/nixos/nixpkgs) or from [opam-repository](https://github.com/ocaml/opam-repository),
- with either dynamic or static linking.

It also comes with the power of Nix, allowing you to effortlessly manage
multiple projects with different dependency versions, override dependencies,
cache builds, and more.

## Quick start

For a quick introduction to `opam-nix` and a guide to get you started, read [this blog post on the Tweag blog](https://www.tweag.io/blog/2023-02-16-opam-nix/).

## Templates

`opam-nix` comes with some templates that can help you package opam packages with Nix.

> **Note**
>
> All of these templates assume that you already have an OCaml project packaged
> with opam, and just want to package it with Nix. If you're starting from
> scratch, you have to set up the opam files separately. The easiest way to do
> this is by running `nix-shell -p dune_3 --run "dune init project <project_name> ."`

- A simple package build, no frills: `nix flake init -t github:tweag/opam-nix`
- A more featured flake, building an executable and providing a shell in which you can conveniently work on it: `nix flake init -t github:tweag/opam-nix#executable`
- Build multiple packages from the same workspace, and have a shell in which you can work on them: `nix flake init -t github:tweag/opam-nix#multi-package`

> **Note**
>
> If you're using Git, you should `git add flake.nix` after initializing, as Nix operates on the git index contents.

## Examples

There are also some examples which can give you some ideas of what is possible with `opam-nix`:

- [Building a package from opam-repository](./examples/0install/flake.nix)
- [Building a package from a custom github repository](./examples/opam2json/flake.nix)
- [Building a package from a multi-package github repository with submodules](./examples/ocaml-lsp/flake.nix)
- [Building a Coq package](./examples/coq/flake.nix)
- [Building a static version of a package using compiler from nixpkgs](./examples/opam-ed/flake.nix)
- [Building a static version of a package using the compiler from opam](./examples/opam2json-static/flake.nix)
- [Building a GUI package](./examples/frama-c/flake.nix)
- [Building the entirety of Tezos](./examples/tezos/flake.nix)

All examples are checks and packages, so you can do e.g. `nix build
github:tweag/opam-nix#opam-ed` to try them out individually, or `nix
flake check github:tweag/opam-nix` to build them all.

## Building packages from opam-repository with Nix

`opam-nix` provides all packages from `opam-repository` in its `legacyPackages` flake output.
You can use this to quickly check out some package, or get a shell with particular version without messing with opam switches.

For example:

- `nix build 'github:tweag/opam-nix#utop."2.10.0"'` to build a specific version of utop (available in `./result`),
- `nix shell github:tweag/opam-nix#camyll.latest` to get a shell with the latest version of [`camyll`](https://alan-j-hu.github.io/camyll/).

## Complete documentation

Complete documentation for `opam-nix` is available in the [DOCUMENTATION.md](./DOCUMENTATION.md) file.

## Questions? Problems?

You can reach out to us via the [Discussions page](https://github.com/tweag/opam-nix/discussions/categories/q-a) or directly to the maintainer [via email](mailto:alexander.bantyev@tweag.io).

## Related projects

- [Nix](https://github.com/nixos/nix): A powerful package manager that makes package management reliable and reproducible;
- [opam](https://github.com/ocaml/opam): the OCaml package manager;
- [hillingar](https://github.com/ryanGibb/hillingar): Tool for building MirageOS unikernels with opam-nix.
