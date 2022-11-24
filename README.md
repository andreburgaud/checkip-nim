# CheckIP

If you are connected to the internet, `checkip` display your current IP address.
By default, it fetches this information from https://checkip.amazonaws.com, but you can
supply a different site, for example, https://ifconfig.co/.

I built this tool to retrieve a machine's current external IP address programmatically, but there are other alternatives using tools possibly installed on your devices. See section **Alternatives** for examples.

## Usage

### Display your IP Address

Without any arguments, `checkip` fetches your current IP address from https://checkip.amazonaws.com:

```
$ checkip
66.249.73.63
```

You can use the `url` option to supply a site that will return you IP address:

```
$ checkip --url=https://ifconfig.co
66.249.73.63
```

## Build

### Debug

```
$ nimble build -d:ssl
```

### Release

```
$ nimble build -d:ssl -d:release
$ strip checkip
```

Optionally, to reduce the size further:

```
$ upx checkip
```

## Known Problems

* Requires Nim 1.6.10 with OpenSSL 3 support to work in environment with OpenSSL 3
* https://nim-lang.org/blog/2022/11/23/version-1610-released.html
* https://www.mail-archive.com/nim-general@lists.nim-lang.org/msg19309.html

# Alternatives

## wget

```
$ wget -O- -q https://checkip.amazonaws.com
66.249.73.63
$ wget -O- -q https://ifconfig.co 
66.249.73.63
```

## curl

```
$ curl https://checkip.amazonaws.com
66.249.73.63
$ curl https://ifconfig.co
66.249.73.63
```
