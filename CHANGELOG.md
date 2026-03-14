# Changelog

## [1.0.1](https://github.com/fohte/runok-presets/compare/v1.0.0...v1.0.1) (2026-03-14)


### Bug Fixes

* **readonly-unix:** allow `command -v` / `command -V` ([#110](https://github.com/fohte/runok-presets/issues/110)) ([6bf13e7](https://github.com/fohte/runok-presets/commit/6bf13e7833511b979886035bb37684a1dd00b4d7))
* **readonly-unix:** allow shell control flow builtins ([#24](https://github.com/fohte/runok-presets/issues/24)) ([d46b3b3](https://github.com/fohte/runok-presets/commit/d46b3b39f35e76af3a768f74b8138747859783a5))

## [1.0.0](https://github.com/fohte/runok-presets/compare/v0.1.0...v1.0.0) (2026-03-12)


* trigger initial release ([5c53162](https://github.com/fohte/runok-presets/commit/5c531621d45e034e1fc6b8affc7b5985a7decaac))


### Features

* add preset files for read-only command permissions ([#2](https://github.com/fohte/runok-presets/issues/2)) ([b8f9a6f](https://github.com/fohte/runok-presets/commit/b8f9a6f8188c675e9be45fea413daf6180408a80))
* add read-only preset for GitHub CLI (`gh`) ([#18](https://github.com/fohte/runok-presets/issues/18)) ([3034938](https://github.com/fohte/runok-presets/commit/303493881bdc9e0f4a9adb38be675842eb7f51e2))
* **definitions:** add wrapper definitions for `command`, `timeout`, `nice`, `nohup`, `stdbuf` ([#16](https://github.com/fohte/runok-presets/issues/16)) ([360a9af](https://github.com/fohte/runok-presets/commit/360a9af920ea4fce8e0429ab7e80c6c16c5c6548))
* **readonly-gh:** relax `gh browse` restriction and block `gh api --paginate` ([#19](https://github.com/fohte/runok-presets/issues/19)) ([94ac0fe](https://github.com/fohte/runok-presets/commit/94ac0fe05dcf8f766203acadb3722f0a2278c5ab))
* **readonly-git:** add missing read-only git subcommands ([#15](https://github.com/fohte/runok-presets/issues/15)) ([27e2a4c](https://github.com/fohte/runok-presets/commit/27e2a4c0dff912c61046af5e6c6e5da7b4b79f83))
* **readonly-git:** support git global options `-C`, `--git-dir`, `--work-tree` ([#6](https://github.com/fohte/runok-presets/issues/6)) ([74f2672](https://github.com/fohte/runok-presets/commit/74f2672201cc32da3a79e284d23088cb1f68d88c))
* **readonly-unix:** add read-only preset for `curl` ([#21](https://github.com/fohte/runok-presets/issues/21)) ([dbf463d](https://github.com/fohte/runok-presets/commit/dbf463d7870a6bf272e0ccb41d8fdb597426938e))


### Bug Fixes

* **readonly-gh:** skip field-flag ask rule for explicit `GET` in `gh api` ([#20](https://github.com/fohte/runok-presets/issues/20)) ([b025ca5](https://github.com/fohte/runok-presets/commit/b025ca5585a4bcd60014c2430baa4be501fa3461))
* **readonly-git:** make `-l|--list` mandatory in `git tag` pattern ([#4](https://github.com/fohte/runok-presets/issues/4)) ([9951bf2](https://github.com/fohte/runok-presets/commit/9951bf2653b4f082d681cdaab94de6842ce7f848))
* **readonly-unix:** exclude arbitrary execution and file write options via negation ([#10](https://github.com/fohte/runok-presets/issues/10)) ([b0d91df](https://github.com/fohte/runok-presets/commit/b0d91dffbc66fae1ef0aef04bd864b7a3dbe77a8))


### Dependencies

* update dependency fohte/runok to v0.1.4 ([#14](https://github.com/fohte/runok-presets/issues/14)) ([b3c450e](https://github.com/fohte/runok-presets/commit/b3c450effa6ec61a9987207ea893c6f033653f68))
