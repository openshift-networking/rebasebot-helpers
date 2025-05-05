#!/bin/bash

set -o nounset
set -o pipefail
set -o xtrace

go mod tidy
go mod vendor
