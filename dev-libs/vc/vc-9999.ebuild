# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

VC_TEST_DATA=( reference-{acos,asin,atan,ln,log2,log10,sincos}-{dp,sp}.dat )
for i in ${VC_TEST_DATA[@]}; do
	SRC_URI+="test? ( http://compeng.uni-frankfurt.de/~kretz/Vc-testdata/$i -> ${P}-${i} ) "
done

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="git://code.compeng.uni-frankfurt.de/vc.git"
	KEYWORDS=""
else
	SRC_URI+=" https://gitorious.org/${PN}/${PN}/archive-tarball/${PV} -> ${P}.tar.gz"
	KEYORDS="~amd64 ~amd64-linux ~x86 ~x86-linux"
fi

DESCRIPTION="A library to ease explicit vectorization of C++ code"
HOMEPAGE="http://code.compeng.uni-frankfurt.de/projects/vc"

LICENSE="LGPL-3"
SLOT="0"
IUSE="test"

src_unpack() {
	git-r3_src_unpack

	if use test ; then
		mkdir -p "${WORKDIR}"/${P}_build/tests || die
		for i in ${VC_TEST_DATA[@]}; do
			cp "${DISTDIR}"/${P}-$i "${WORKDIR}"/${P}_build/tests/${i} || die
		done
	fi
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build test)
	)
	cmake-utils_src_configure
}