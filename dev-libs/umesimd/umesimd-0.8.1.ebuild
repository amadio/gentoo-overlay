# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="C++ library for explicit SIMD vectorization"
HOMEPAGE="https://github.com/edanor/umesimd"
SRC_URI="https://github.com/edanor/umesimd/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~amd64-linux ~x64-macos"
IUSE="examples"

DOCS="doc/*.txt"

src_install() {
	default_src_install
	use examples && dodoc -r examples
	insinto /usr/include/${PN}
	doins -r *.h plugins utilities
}
