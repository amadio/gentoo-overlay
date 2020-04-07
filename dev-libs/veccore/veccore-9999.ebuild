# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="Open source library for portable SIMD programming"
HOMEPAGE="https://github.com/root-project/veccore"
EGIT_REPO_URI="https://github.com/root-project/veccore"

LICENSE="Apache-2.0"
SLOT="0"
# KEYWORDS="~amd64 ~amd64-linux ~arm-linux ~x64-macos"
IUSE="test vc umesimd"

RDEPEND="vc? ( dev-libs/vc ) umesimd? ( dev-libs/umesimd )"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
		-DUMESIMD=$(usex umesimd)
		-DVC=$(usex vc)
	)
	cmake-utils_src_configure
}
