# Selenium Manager

Selenium Manager is a standalone tool that automatically manages the browser infrastructure required by Selenium (i.e., browsers and drivers). In other words, it implements the concept of the so-called _batteries included_ concept in Selenium.

## Rust installation
Selenium Manager has been implemented as a CLI (Command-Line Interface) tool using [Rust](https://www.rust-lang.org/). Therefore, to run it from the source code, you need to [install Rust and Cargo](https://doc.rust-lang.org/cargo/getting-started/installation.html). On Linux and macOS systems, this is done as follows:

```
curl https://sh.rustup.rs -sSf | sh
```

Alternatively, you can build it using [Bazel](https://bazel.build) by executing `bazel build //rust:selenium-manager` from the top-level directory of the Selenium repo (the same one where the `WORKSPACE` file is).

## Usage
Selenium Manager can be executed using Cargo as follows:

```
$ cargo run -- --help
selenium-manager 1.0.0-M1
Automated driver management for Selenium

Usage: selenium-manager [OPTIONS]
Options:
  -b, --browser <BROWSER>
          Browser name (chrome, firefox, or edge) [default: ]
  -d, --driver <DRIVER>
          Driver name (chromedriver, geckodriver, or msedgedriver) [default: ]
  -v, --driver-version <DRIVER_VERSION>
          Driver version (e.g., 106.0.5249.61, 0.31.0, etc.) [default: ]
  -B, --browser-version <BROWSER_VERSION>
          Major browser version (e.g., 105, 106, etc.) [default: ]
  -D, --debug
          Display DEBUG messages
  -T, --trace
          Display TRACE messages
  -c, --clear-cache
          Clear driver cache
  -h, --help
          Print help information
  -V, --version
          Print version information
```

For instance, the command required to manage chromedriver is the following:

```
$ cargo run -- --browser chrome
INFO	/home/boni/.cache/selenium/chromedriver/linux64/106.0.5249.61/chromedriver
```
If everything is correct, the last line contains the path to the driver (which will be used in the bindings). To get `DEBUG` traces, we can use:

```
$ cargo run -- --browser chrome --debug
DEBUG	Clearing cache at: /home/boni/.cache/selenium
DEBUG	Using shell command to find out chrome version
DEBUG	Running sh command: "google-chrome --version"
DEBUG	Output { status: ExitStatus(unix_wait_status(0)), stdout: "Google Chrome 106.0.5249.91 \n", stderr: "" }
DEBUG	The version of chrome is 106.0.5249.91
DEBUG	Detected browser: chrome 106
DEBUG	Reading chromedriver version from https://chromedriver.storage.googleapis.com/LATEST_RELEASE_106
DEBUG	starting new connection: https://chromedriver.storage.googleapis.com/
DEBUG	Required driver: chromedriver 106.0.5249.61
DEBUG	starting new connection: https://chromedriver.storage.googleapis.com/
DEBUG	File extracted to /home/boni/.cache/selenium/chromedriver/linux64/106.0.5249.61/chromedriver (13158208 bytes)
INFO	/home/boni/.cache/selenium/chromedriver/linux64/106.0.5249.61/chromedriver
```

Alternatively, you can replace `cargo run` with `bazel run //rust:selenium-manager`, for example `bazel run //rust:selenium-manager -- --browser chrome --debug`

## Roadmap
The implementation of Selenium Manager has been planned to be incremental. In the beginning, it should be a component that each Selenium language binding can optionally use to manage the local browser infrastructure. In the mid-term, and as long as it becomes more stable and complete, it could be used as the default tool for automated browser and driver management. All in all, the milestone we propose are the following:

| **Milestone**                           | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|-----------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| M1: Driver management                   | <ul><li>Beta version of the Selenium Manager.</li> <li>Focused on driver management for Chrome, Firefox, and Edge.</li> <li>Selenium Manager compiled for Windows, Linux, and macOS (in GH Actions).</li> <li>Available in Selenium binding languages (Java, JavaScript, Python, Ruby, and C#).</li> <li>Used as a fallback for language bindings, when the driver is not found.</li> <li>Selenium Manager binaries bundled within the binding languages.</li></ul> |
| M2: Driver management for IEDriver      | <ul><li>Include driver support for IExplorer.</li></ul>                                                                                                                                                                                                                                                                                                                                                                                                             |
| M3: Rich configuration                  | <ul><li>Proxy support in Selenium Manager.</li> <li>Extra configuration capabilities from binding languages to Selenium Manager (e.g., force to use a given driver version, etc.).</li></ul>                                                                                                                                                                                                                                                                        |
| M4: Browser management: Chrome/Chromium | <ul><li>Analyze how to make browser management for Chrome (or Chromium, if Chrome is not possible).</li> <li>Implement this feature in Windows, Linux, and macOS.</li></ul>                                                                                                                                                                                                                                                                                         |
| M5: Browser management: Firefox         | <ul><li>Analyze how to make browser management for Firefox.</li> <li>Implement this feature in Windows, Linux, and macOS.</li></ul>                                                                                                                                                                                                                                                                                                                                 |
| M6: Browser management: Edge            | <ul><li>Analyze how to make browser management for Edge.</li> <li>Implement this feature in Windows, Linux, and macOS.</li></ul>                                                                                                                                                                                                                                                                                                                                    |
