## What Is This About?

This is a simple example showing why using [**Tini**](https://github.com/krallin/tini) is a good idea in Docker containers AND REALLY easy to implement for HA systems mainly (easy developments not 100% necesssary)

### Directylly, why to use Tini?

- Catches system signals like `SIGTERM` and forwards them to your app and childs processes.
- Reaps zombie processes to avoid memory leaks

### Build the Docker Images

####With Tini

```bash
docker build -t yt-alpine-yes-tini:0.0.1 -f Dockerfile-yes-tini .
```

Run it:

```bash
docker run -it --rm --name yt-yes-tini yt-alpine-yes-tini:0.0.1
```

Output (example process tree):

```
PID   PPID  COMMAND
  1     0   tini
  7     1   ps
  8     7   sleep
```

Here, **Tini runs as PID 1**, and manages child processes correctly.

#### ❌ Without Tini

```bash
docker build -t yt-alpine-no-tini:0.0.1 -f Dockerfile-no-tini .
```

Run it:

```bash
docker run -it --rm --name yt-no-tini yt-alpine-no-tini:0.0.1
```

Output:

```
PID   PPID  COMMAND
  1     0   ps
  7     1   sleep
```

Here, `ps` is PID 1 — it's not a real init system, so **signals and zombie processes are not handled properly**.

**EXTRAS**
- Tini is also compatibale with podman.
