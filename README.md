# CheckIP

If you are connected to the internet, `checkip` displays your external IP address.
By default, it uses `DNS` to fetch this information. If you pass an `--http` flag, it will use `HTTP`. `DNS` is a faster option than `HTTP`.

I built this tool to retrieve a machine's current external IP address programmatically, but there are other alternatives using tools possibly installed on your devices. See section **Alternatives** for examples.

## Usage

### Display your IP Address

Without any arguments, `checkip` fetches your external IP address:

```
checkip
66.249.73.63
```

By default, it uses `DNS` and is the equivalent of running:

```
dig +short myip.opendns.com @resolver1.opendns.com
66.249.73.63
```


You can use the `--url` option to use `HTTP` instead of `DNS`:

```
$ checkip --http
66.249.73.63
```

It is the equivalent of running:

```
curl https://checkip.amazonaws.com
66.249.73.63
```

## Build

* Requires Nim 2.0.0

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

# Alternatives

## wget

```
wget -O- -q https://checkip.amazonaws.com
66.249.73.63
```

```
wget -O- -q https://ifconfig.co
66.249.73.63
```

## curl

```
curl https://checkip.amazonaws.com
66.249.73.63
```

```
curl https://ifconfig.co
66.249.73.63
```

## dig

```
dig +short myip.opendns.com @resolver1.opendns.com
66.249.73.63
```


# Resources

* https://github.com/mpolden/echoip
* https://ifconfig.co/
