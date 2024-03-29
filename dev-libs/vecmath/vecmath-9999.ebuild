# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="SIMD math library built on top of VecCore"
HOMEPAGE="https://github.com/root-project/vecmath"
EGIT_REPO_URI="https://github.com/root-project/vecmath"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="test? ( dev-libs/vc )"
RDEPEND="dev-libs/vdt"

src_prepare() {
	# use correct libdir
	sed -i -e "s@lib/cmake@$(get_libdir)/cmake@g" CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
		-DBUILD_BENCHMARKS=$(usex test)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	# remove includes pointing to build directory
	sed -i -e '/.*INTERFACE_INCLUDE_DIRECTORIES/d' \
		"${ED%}/usr/$(get_libdir)/cmake/VecMath/VecMathTargets.cmake" || die
}
