# pip-latest
Bash script to find latest version of a particular pip package

## Sample Usage and Output

```
user@computer:~/pip-latest$ ./pip-latest.sh requests
curl is already installed.
jq is already installed.
Prerequisite check passed.
2.9.2
stressed@desserts:~/pip-latest$
```

## Disclaimer

This is a stupid way to find the latest version of a given pip package. A better way to do this would be to query the public API at PyPI, and parse the output with jq.

```
sudo apt-get install jq
curl -s https://pypi.org/pypi/Flask/json | jq '{version: .info.version}'
```
