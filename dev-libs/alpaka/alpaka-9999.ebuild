# Copyright 1999-2022 Guilherme Amadio
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Abstraction Library for Parallel Kernel Acceleration"
HOMEPAGE="https://github.com/alpaka-group/alpaka"
EGIT_REPO_URI="https://github.com/alpaka-group/alpaka"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"

DEPEND="dev-libs/boost"

RESTRICT="!test? ( test )"
