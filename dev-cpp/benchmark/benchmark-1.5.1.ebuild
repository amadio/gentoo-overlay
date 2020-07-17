# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_ECLASS=cmake
inherit cmake-multilib

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/google/benchmark"
else
	SRC_URI="https://github.com/google/benchmark/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
fi

DESCRIPTION="Google microbenchmark support library"
HOMEPAGE="https://github.com/google/googletest"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="exceptions lto test"
RESTRICT="!test? ( test )"

src_prepare() {
	cmake_src_prepare
}

multilib_src_configure() {
	local mycmakeargs=(
		-DBENCHMARK_ENABLE_TESTING=$(usex test)
		-DBENCHMARK_ENABLE_EXCEPTIONS=$(usex exceptions)
		-DBENCHMARK_ENABLE_LTO=$(usex lto)
		-DBENCHMARK_USE_LIBCXX=no
		-DBENCHMARK_BUILD_32_BITS=no
		-DBENCHMARK_ENABLE_INSTALL=yes
		-DBENCHMARK_DOWNLOAD_DEPENDENCIES=no
		-DBENCHMARK_ENABLE_GTEST_TESTS=no
		-DBENCHMARK_ENABLE_ASSEMBLY_TESTS=no
	)
	cmake_src_configure
}

multilib_src_install_all() {
	einstalldocs
}
