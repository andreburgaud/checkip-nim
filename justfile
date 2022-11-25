BUILD_DIR := "build"
DIST_DIR := "dist"
APP := "checkip"
VERSION := "0.4.0"

# Default recipe (this list)
default:
    @echo "OS: {{os()}}, OS Family: {{os_family()}}, architecture: {{arch()}}"
    @just --list

# Clean binaries
clean:
    -rm -rf {{BUILD_DIR}}
    -rm -rf {{DIST_DIR}}
    -rm -rf tmp
    -rm tests/test_{{APP}}

# Debug build
build:
    nimble build -d:ssl

# Check version
version:
    nimble check_version

# Release build
release: test clean version
    nimble build -d:ssl -d:release
    strip {{BUILD_DIR}}/{{APP}}
    upx {{BUILD_DIR}}/{{APP}}

# Zip a package to push as a release to github
dist: release
    -mkdir {{DIST_DIR}}
    zip -j {{DIST_DIR}}/{{APP}}_{{os()}}_{{arch()}}_{{VERSION}}.zip {{BUILD_DIR}}/{{APP}}

# Run unittests Test a few options via the CLI
test: build
    nimble --verbose test

# Test a few options via the CLI
run: build
    build/checkip
    build/checkip --help
    build/checkip -h
    build/checkip --version
    build/checkip -V
    build/checkip --verbose
    build/checkip -v
    build/checkip --url=https://ifconfig.co
    build/checkip -u=https://ifconfig.co
    build/checkip -v -u=https://ifconfig.co

push:
    git push
    git tag -a {{VERSION}} -m 'Version {{VERSION}}'
    git push origin --tags
