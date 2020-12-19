import os, strformat

const ipfsInfo = {
    "version":"0.7.0",
    "platform":"linux",
    "arch":"x64"
}
echo ipfsInfo

# let temDir = getTempDir() / "uii"

## configs
let temDir = "./"
# when linux
let installCmd = "sh"
let installFile = "install.sh"
let installDir = "/usr/bin"

let downToNim = temDir / "nim"
let downToNimble = temDir / "nimble"

let platform = "linux"
let arch = "x64"
let nimVersion = "1.5.1"
let nimbleVersion = "0.12.0"

let nimFileDir = temDir / "nim-"&nimVersion
let nimbleFileDir = temDir / "nimble-"&nimbleVersion



## nim
# TODO:add nimble path

let nimAddr = fmt"/ipns/unimcli.unim.top/nim/nim-{nimVersion}-{platform}_{arch}.tar.xz"
let nimbleAddr = fmt"/ipns/unimcli.unim.top/nimble/nimble-{nimbleVersion}.tar.gz"


# download nim
discard execShellCmd(fmt"./ipfs get -o={downToNim} {nimAddr} && tar -xJf {downToNim}")


# install nim
echo "install nim"
discard execShellCmd(fmt"cd {nimfileDir} && {installCmd} {installFile} {installDir}")


## nimble
# download nimble
discard execShellCmd(fmt"./ipfs get -o={downToNimble} {nimbleAddr} && tar -zxf {downToNimble}")

# install nimble
echo "install nimble & unimcli...."
let nimbleSrc = nimbleFileDir / "src"
discard execShellCmd(fmt"cd {nimbleSrc} && nim c -d:release -o:../ nimble.nim")
discard execShellCmd(fmt"cd {nimbleFileDir} && ./nimble install")
discard execShellCmd("nimble install unimcli")

