# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="Vectorized math library from CERN"
HOMEPAGE="https://github.com/dpiparo/vdt"
EGIT_REPO_URI="https://github.com/dpiparo/vdt"

LICENSE="LGPL-3+"
SLOT="0"
# KEYWORDS="~amd64 ~amd64-linux ~arm-linux ~x64-macos"

src_prepare() {
	sed -i -e "/DESTINATION lib/s@lib@$(get_libdir)@" lib/CMakeLists.txt
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DSSE=OFF # breaks on arm
		-DUSERFLAGS="$CXXFLAGS"
	)
	cmake-utils_src_configure
}
