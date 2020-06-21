# Copyright 1999-2020 Guilherme Amadio
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="C++ Library for Portable SIMD Vectorization"
HOMEPAGE="https://github.com/root-project/veccore"
EGIT_REPO_URI="https://github.com/root-project/veccore"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test vc umesimd"

RESTRICT="!test? ( test )"

RDEPEND="
	umesimd? ( dev-libs/umesimd )
	vc? ( dev-libs/vc )
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
		-DUMESIMD=$(usex umesimd)
		-DVC=$(usex vc)
	)
	cmake_src_configure
}
