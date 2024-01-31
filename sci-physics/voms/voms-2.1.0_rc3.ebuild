# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Virtual Organization Membership Service"
HOMEPAGE="https://github.com/italiangrid/voms"
SRC_URI="https://github.com/italiangrid/voms/archive/refs/tags/v${PV/_/-}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
		dev-libs/expat
		dev-libs/libxslt
		dev-libs/openssl:0=
		net-libs/gsoap
"
RDEPEND="${DEPEND}"
BDEPEND="dev-build/libtool"

PATCHES=(
	"${FILESDIR}"/voms-2.1.0-c99.patch
	"${FILESDIR}"/voms-2.1.0-config-h.patch
	"${FILESDIR}"/voms-2.1.0-exception.patch
	"${FILESDIR}"/voms-2.1.0-warnings.patch
)

S="${WORKDIR}"/${PN}-${PV/_/-}

src_prepare() {
		default
		mkdir -p aux src/autogen
		cp "${FILESDIR}"/INSTALL "${S}"
		eautoreconf
}

src_configure() {
	econf --disable-static --enable-docs --disable-parser-gen
}

src_install() {
	default
	dodoc "${FILESDIR}"/INSTALL
	docompress -x /usr/share/man/man3
	find "${ED}" -name '*.la' -delete || die
	keepdir /var/lib/log/voms
}
