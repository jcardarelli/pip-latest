# pip-latest
Bash script to find latest version of a particular pip package

This is a stupid way to find the latest version of a given pip package. A better way to do this would be to query the public API at PyPI, and parse the output with jq.

Example search:
```
sudo apt-get install jq
curl -s https://pypi.org/pypi/Flask/json | jq '{version: .info.version}'
```
