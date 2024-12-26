# Resume

<legend>
Just my resume with automatic deployment, really.
<img src="https://github.com/KINFOO/resume/actions/workflows/test.yml/badge.svg" alt="Build status"/>
</legend>

## Prerequisites

- `curl`
- `make`
- `npx`
- `pipx`

## Generate pdf & html resume

```bash
make resume
```

Or simply

```bash
make
```

## Release

Releases and updates changelog.

```bash
make release
```

## Deploy

Sends generated resume to my website.

```bash
make deploy
```
