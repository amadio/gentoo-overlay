# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Flexible & Powerful Open Source Multi-Protocol Messaging"
HOMEPAGE="https://activemq.apache.org/"
SRC_URI="https://github.com/apache/activemq-cpp/archive/refs/tags/${P}.tar.gz"

S="${WORKDIR}/${PN}-${P}/${PN}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/apr
	dev-libs/apr-util
	dev-libs/openssl:=
	virtual/zlib:=
"

DEPEND="
	${RDEPEND}
	!elibc_Darwin? ( sys-apps/util-linux )
"
BDEPEND="
	test? (
		dev-util/cppunit
	)
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf --disable-static
}

src_install() {
	default
	rm "${ED}"/usr/$(get_libdir)/libactivemq-cpp.la || die
}

src_test() {
	emake check
}
