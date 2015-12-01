# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils git-r3

DESCRIPTION="SIMD Vector Class Library for C++"
HOMEPAGE="https://github.com/VcDevel/Vc"

VC_TEST_DATA=( reference-{acos,asin,atan,ln,log2,log10,sincos}-{dp,sp}.dat )
for i in ${VC_TEST_DATA[@]}; do
	SRC_URI+="test? ( http://compeng.uni-frankfurt.de/~kretz/Vc-testdata/$i -> ${P}-${i} ) "
done

EGIT_REPO_URI="https://github.com/VcDevel/Vc"
KEYWORDS="~x86 ~amd64"

LICENSE="LGPL-3"
SLOT="0"
IUSE="test mic"

src_unpack() {
	git-r3_src_unpack

	if use test ; then
		mkdir -p "${WORKDIR}"/${P}_build/tests || die
		for i in ${VC_TEST_DATA[@]}; do
			cp "${DISTDIR}"/${P}-$i "${WORKDIR}"/${P}_build/tests/${i} || die
		done
	fi
}

src_prepare() {
	epatch \
	"${FILESDIR}"/${PN}-optional-mic-build.patch \
	"${FILESDIR}"/${P}-find-mic.patch
}

src_configure() {
	sed -i -e "s:@EPREFIX@:${EPREFIX}:" "${S}"/cmake/FindMIC.cmake || die

	local mycmakeargs="
		$(cmake-utils_use_build test)
		$(cmake-utils_use_build mic MIC)
	"
	cmake-utils_src_configure
}
