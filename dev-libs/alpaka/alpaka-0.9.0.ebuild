# Copyright 1999-2022 Guilherme Amadio
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Abstraction Library for Parallel Kernel Acceleration"
HOMEPAGE="https://github.com/alpaka-group/alpaka"
SRC_URI="https://github.com/alpaka-group/alpaka/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="test"

DEPEND="dev-libs/boost"

RESTRICT="!test? ( test )"
