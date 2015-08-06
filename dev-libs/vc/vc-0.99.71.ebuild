# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

VC_TEST_DATA=( reference-{acos,asin,atan,ln,log2,log10,sincos}-{dp,sp}.dat )
for i in ${VC_TEST_DATA[@]}; do
	SRC_URI+="test? ( http://compeng.uni-frankfurt.de/~kretz/Vc-testdata/$i -> ${P}-${i} ) "
done

SRC_URI+=" https://github.com/VcDevel/Vc/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~amd64-linux ~x86 ~x86-linux"

DESCRIPTION="SIMD Vector Class Library for C++"
HOMEPAGE="https://github.com/VcDevel/Vc"

LICENSE="LGPL-3"
SLOT="0"
IUSE="test mic"

src_unpack() {
	default_src_unpack
	S="${WORKDIR}"/Vc-${PV}
	if use test ; then
		mkdir -p "${WORKDIR}"/${P}_build/tests || die
		for i in ${VC_TEST_DATA[@]}; do
			cp "${DISTDIR}"/${P}-$i "${WORKDIR}"/${P}_build/tests/${i} || die
		done
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-optional-mic-build.patch
}

src_configure() {
	local mycmakeargs="
		$(cmake-utils_use_build test)
		$(cmake-utils_use_build mic MIC)
	"
	cmake-utils_src_configure
}