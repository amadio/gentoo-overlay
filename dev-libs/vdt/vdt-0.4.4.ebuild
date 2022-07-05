# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Vectorized math library from CERN"
HOMEPAGE="https://github.com/dpiparo/vdt"
SRC_URI="https://github.com/dpiparo/vdt/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~amd64-linux ~arm-linux ~x64-macos"

src_prepare() {
	sed -i -e "/DESTINATION lib/s@lib@$(get_libdir)@" lib/CMakeLists.txt
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DSSE=OFF # breaks on arm
		-DUSERFLAGS="$CXXFLAGS"
	)
	cmake_src_configure
}
